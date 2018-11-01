# frozen_string_literal: true

require_relative '../attribute_instruction'

class ActiveSet
  module Filtering
    class Operation
      def initialize(set, instructions_hash)
        @set = set
        @instructions_hash = instructions_hash
      end

      def execute
        attribute_instructions = @instructions_hash
                                   .flatten_keys
                                   .map { |k, v| AttributeInstruction.new(k, v) }

        activerecord_filtered_set = attribute_instructions.reduce(@set) do |set, attribute_instruction|
          maybe_set_or_false = ActiveRecordStrategy.new(set, attribute_instruction).execute
          next set unless maybe_set_or_false

          attribute_instruction.processed = true
          maybe_set_or_false
        end

        return activerecord_filtered_set if attribute_instructions.all?(&:processed?)

        attribute_instructions.reject(&:processed?).reduce(activerecord_filtered_set) do |set, attribute_instruction|
          maybe_set_or_false = EnumerableStrategy.new(set, attribute_instruction).execute
          maybe_set_or_false.presence || set
        end
      end

      def operation_instructions
        @instructions_hash.symbolize_keys
      end
    end

    class EnumerableStrategy
      def initialize(set, attribute_instruction)
        @set = set
        @attribute_instruction = attribute_instruction
      end

      def execute
        return false unless @set.respond_to? :select

        @set.select do |item|
          if execute_attribute_comparison_for?(item)
            next attribute_comparison_for(item)
          elsif execute_class_method_call_for?(item)
            next class_method_call_for(item)
          else
            next false
          end
        end
      end

      private

      def execute_attribute_comparison_for?(item)
        attribute_item = attribute_item_for(item)

        return false unless attribute_item
        return false unless attribute_item.respond_to?(@attribute_instruction.attribute)
        return false unless attribute_item.method(@attribute_instruction.attribute).arity.zero?

        true
      end

      def execute_class_method_call_for?(item)
        attribute_item = attribute_item_for(item)

        return false unless attribute_item
        return false unless attribute_item.class
        return false unless attribute_item.class.respond_to?(@attribute_instruction.attribute)
        return false if attribute_item.class.method(@attribute_instruction.attribute).arity.zero?

        true
      end

      def attribute_comparison_for(item)
        @attribute_instruction
          .value_for(item: item)
          .public_send(
            @attribute_instruction.operator,
            @attribute_instruction.value
          )
      end

      def class_method_call_for(item)
        maybe_item_or_collection_or_nil = attribute_item_for(item)
                                          .class
                                          .public_send(
                                            @attribute_instruction.attribute,
                                            @attribute_instruction.value
                                          )
        if maybe_item_or_collection_or_nil.nil?
          false
        elsif maybe_item_or_collection_or_nil.respond_to?(:each)
          maybe_item_or_collection_or_nil.include? attribute_item_for(item)
        else
          maybe_item_or_collection_or_nil.present?
        end
      end

      def attribute_item_for(item)
        @attribute_instruction
          .resource_for(item: item)
      end
    end

    class ActiveRecordStrategy
      def initialize(set, attribute_instruction)
        @set = set
        @attribute_instruction = attribute_instruction
      end

      def execute
        return false unless @set.respond_to? :to_sql

        if execute_where_operation?
          statement = where_operation
        elsif execute_merge_operation?
          statement = merge_operation
        else
          return false
        end

        return false if throws?(ActiveRecord::StatementInvalid) { statement.load }

        statement
      end

      private

      def execute_where_operation?
        return false unless attribute_model
        return false unless attribute_model.respond_to?(:attribute_names)
        return false unless attribute_model.attribute_names.include?(@attribute_instruction.attribute)

        true
      end

      def execute_merge_operation?
        return false unless attribute_model
        return false unless attribute_model.respond_to?(@attribute_instruction.attribute)
        return false if attribute_model.method(@attribute_instruction.attribute).arity.zero?

        true
      end

      def where_operation
        arel_operator = @attribute_instruction.operator(default: '=')
        arel_column = Arel::Table.new(attribute_model.table_name)[@attribute_instruction.attribute]
        arel_value = Arel.sql(ActiveRecord::Base.connection.quote(@attribute_instruction.value))

        @set.eager_load(@attribute_instruction.associations_hash)
            .where(
              Arel::Nodes::InfixOperation.new(
                arel_operator,
                arel_column,
                arel_value
              )
            )
      end

      def merge_operation
        @set.eager_load(@attribute_instruction.associations_hash)
            .merge(
              attribute_model.public_send(
                @attribute_instruction.attribute,
                @attribute_instruction.value
              )
            )
      end

      def attribute_model
        return @set.klass if @attribute_instruction.associations_array.empty?

        @attribute_instruction
          .associations_array
          .reduce(@set) do |obj, assoc|
            obj.reflections[assoc.to_s]&.klass
          end
      end
    end
  end
end
