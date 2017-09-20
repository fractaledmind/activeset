# frozen_string_literal: true

require_relative '../base_adapter'

class ActiveSet
  class FilterProcessor < BaseProcessor
    class EnumerableAdapter < BaseAdapter
      def process(set)
        set.select do |item|
          value_for(item).send(@instruction.operator,
                               passed_value)
        end
      end

      private

      def value_for(item)
        convert_datetime_values_to_integer(@instruction.value_for(item: item))
      end

      def passed_value
        convert_datetime_values_to_integer(@instruction.value)
      end

      def convert_datetime_values_to_integer(value)
        # DateTimes (and Times) are tricky to compare, Integers are easier
        # and I only care about second precision
        return value unless value.is_a?(DateTime)
        value.to_i
      end
    end
  end
end
