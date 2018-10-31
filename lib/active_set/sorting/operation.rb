# frozen_string_literal: true

require_relative '../attribute_instruction'

module Sorting
  class Operation
    def initialize(set, instructions_hash)
      @set = set
      @instructions_hash = instructions_hash
    end

    def execute
      attribute_instructions = @instructions_hash
                                 .flatten_keys
                                 .map { |k, v| AttributeInstruction.new(k, v) }

      activerecord_strategy = ActiveRecordStrategy.new(@set, attribute_instructions)
      if activerecord_strategy.executable_instructions == attribute_instructions
        activerecord_sorted_set = activerecord_strategy.execute
      end

      return activerecord_sorted_set if attribute_instructions.all?(&:processed?)

      EnumerableStrategy.new(@set, attribute_instructions).execute
    end

    def operation_instructions
      @instructions_hash.symbolize_keys
    end
  end

  class EnumerableStrategy
    def initialize(set, attribute_instructions)
      @set = set
      @attribute_instructions = attribute_instructions
    end

    def execute
      @set.sort_by do |item|
        @attribute_instructions.map do |instruction|
          sortable_numeric_for(instruction, item) * direction_multiplier(instruction.value)
        end
      end
    end

    def sortable_numeric_for(instruction, item)
      value = instruction.value_for(item: item)

      if value == true
        return 1
      elsif value == false
        return 0
      elsif value.is_a?(Numeric)
        return value
      elsif value.is_a?(String) || value.is_a?(Symbol)
        string_value = if case_insensitive?(instruction, value)
                         value.to_s.downcase
                       else
                         value.to_s
                       end
        # 'aB09ü'
        # -> ["a", "B", "0", "9", "ü"]
        # -> ["097", "066", "048", "057", "252"]
        # -> ["097", ".", "066", "048", "057", "252"]
        # -> "097.066048057252"
        # -> (24266512014313/250000000000)
        return string_value
               .split('')
               .map { |char| char.ord.to_s.rjust(3, '0') }
               .insert(1, '.')
               .reduce(&:concat)
               .to_r
      elsif value.respond_to?(:to_time)
        return (value.to_time.to_f * 1000).round
      else
        # :nocov:
        return value
        # :nocov:
      end
    end

    def case_insensitive?(instruction, _value)
      instruction.operator.to_s.casecmp('i').zero?
    end

    def direction_multiplier(direction)
      return -1 if direction.to_s.downcase.start_with? 'desc'

      1
    end
  end

  class ActiveRecordStrategy
    def initialize(set, attribute_instructions)
      @set = set
      @attribute_instructions = attribute_instructions
    end

    def execute
      return false unless @set.respond_to? :to_sql

      executable_instructions.reduce(set_with_eager_loaded_associations) do |set, attribute_instruction|
        statement = set.merge(order_operation_for(attribute_instruction))

        return false if throws?(ActiveRecord::StatementInvalid) { statement.load }

        attribute_instruction.processed = true
        statement
      end
    end

    def executable_instructions
      return {} unless @set.respond_to? :to_sql

      @attribute_instructions.select do |attribute_instruction|
        attribute_model = attribute_model_for(attribute_instruction)
        next false unless attribute_model
        next false unless attribute_model.respond_to?(:attribute_names)
        next false unless attribute_model.attribute_names.include?(attribute_instruction.attribute)

        true
      end
    end

    private

    def set_with_eager_loaded_associations
      associations_hash = @attribute_instructions.reduce({}) { |h, i| h.merge(i.associations_hash) }
      @set.eager_load(associations_hash)
    end

    def order_operation_for(attribute_instruction)
      attribute_model = attribute_model_for(attribute_instruction)

      arel_column = Arel::Table.new(attribute_model.table_name)[attribute_instruction.attribute]
      arel_column = case_insensitive?(attribute_instruction) ? arel_column.lower : arel_column

      arel_direction = direction_operator(attribute_instruction.value)

      attribute_model.order(arel_column.send(arel_direction))
    end

    def attribute_model_for(attribute_instruction)
      return @set.klass if attribute_instruction.associations_array.empty?

      attribute_instruction
        .associations_array
        .reduce(@set) do |obj, assoc|
          obj.reflections[assoc.to_s]&.klass
        end
    end

    def case_insensitive?(attribute_instruction)
      attribute_instruction.operator.to_s.casecmp('i').zero?
    end

    def direction_operator(direction)
      return :desc if direction.to_s.downcase.start_with? 'desc'

      :asc
    end
  end
end
