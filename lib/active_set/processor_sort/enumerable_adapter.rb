# frozen_string_literal: true

require_relative '../adapter_base'
require_relative '../processor_base'

class ActiveSet
  class Processor::Sort < Processor::Base
    class EnumerableAdapter < Adapter::Base
      def process
        @set.sort do |left, right|
          @instructions.reduce(0) do |diff, instruction|
            # `left` and `right` differed at an earlier order entry
            next diff if diff != 0

            left_value = sortable_attribute_for(left, instruction)
            right_value = sortable_attribute_for(right, instruction)

            # handle `nil` values
            next  0 if left_value.nil? && right_value.nil?
            next  1 if left_value.nil?
            next -1 if right_value.nil?

            # do the actual comparison
            comparison = left_value <=> right_value
            next comparison * direction_multiplier(instruction.value)
          end
        end
      end

      private

      def sortable_attribute_for(item, instruction)
        value = instruction.value_for(item: item)

        return value.to_s.downcase if case_insensitive?(instruction)

        value
      end

      def case_insensitive?(instruction)
        instruction.operator.to_s == 'i'
      end

      def direction_multiplier(direction)
        return -1 if direction.to_s.start_with? 'desc'

        1
      end
    end
  end
end
