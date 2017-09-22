# frozen_string_literal: true

require_relative '../base_adapter'
require_relative '../base_processor'

class ActiveSet
  class SortProcessor < BaseProcessor
    class EnumerableAdapter < BaseAdapter
      def process
        return_set(sorted_set)
      end

      private

      def sorted_set
        @set.sort_by { |item| sortable_attribute_for(item: item) }
            .tap { |c| c.reverse! if descending? }
      end

      def sortable_attribute_for(item:)
        attribute_value = @instruction.value_for(item: item)
        case_insensitive?(attribute_value) ? insensify(attribute_value) : attribute_value
      end

      def case_insensitive?(value)
        # Cannot sort pure Booleans or Nils, so we _must_ cast to Strings
        return true if value.is_a?(TrueClass) || value.is_a?(FalseClass)
        return true if value.is_a?(NilClass)
        @instruction.operator.to_s == 'i'
      end

      def insensify(value)
        value.to_s.downcase
      end

      def descending?
        @instruction.value.to_s == 'desc'
      end
    end
  end
end
