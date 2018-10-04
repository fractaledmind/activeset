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

      EnumerableStrategy.new(@set, attribute_instructions).execute
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
        return string_value.split('').map { |char| char.ord.to_s.rjust(3, '0') }.insert(1, '.').reduce(&:+).to_r
      elsif value.respond_to?(:to_time)
        return (value.to_time.to_f * 1000).round
      elsif value.respond_to?(:to_i)
        return value.to_i
      else
        return value
      end
    end

    def case_insensitive?(instruction, value)
      instruction.operator.to_s.downcase == 'i'
    end

    def direction_multiplier(direction)
      return -1 if direction.to_s.downcase.start_with? 'desc'

      1
    end
  end
end