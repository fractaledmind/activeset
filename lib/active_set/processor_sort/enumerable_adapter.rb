# frozen_string_literal: true

require_relative '../adapter_base'
require_relative '../processor_base'

class ActiveSet
  class Processor::Sort < Processor::Base
    class EnumerableAdapter < Adapter::Base
      def process
        @set.sort do |left, right|
          @instructions.reduce(0) do |diff, instruction|
            # set Adapter::Base#instruction, which many methods depend on
            self.instruction = instruction

            # `left` and `right` differed at an earlier order entry
            next diff if diff != 0

            left_value = sortable_attribute_for(left)
            right_value = sortable_attribute_for(right)

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

      def sortable_attribute_for(item)
        value = instruction.value_for(item: item)

        return value.to_s.downcase if case_insensitive?(value)

        value
      end

      def case_insensitive?(value)
        # Cannot sort pure Booleans or Nils, so we _must_ cast to Strings
        return true if value.is_a?(TrueClass) || value.is_a?(FalseClass)
        return true if value.is_a?(NilClass)

        instruction.operator.to_s.downcase == 'i'
      end

      def direction_multiplier(direction)
        return -1 if direction.to_s.start_with? 'desc'

        1
      end
    end
  end
end
