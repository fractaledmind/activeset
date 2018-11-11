# frozen_string_literal: true

class ActiveSet
  module Filtering
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
        return @attribute_model if defined? @attribute_model

        @attribute_model = @attribute_instruction
                            .associations_array
                            .reduce(@set) do |obj, assoc|
                              obj.reflections[assoc.to_s]&.klass
                            end
      end
    end
  end
end
