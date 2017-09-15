# frozen_string_literal: true

require_relative '../base_adapter'
require_relative '../base_processor'

class ActiveSet
  class SortProcessor < BaseProcessor
    class EnumerableAdapter < BaseAdapter
      def process(set)
        set.sort_by do |item|
          attribute_value = @structure_path.value_for(item: item)
          case_insensitive?(attribute_value) ? insensify(attribute_value) : attribute_value
        end.tap { |c| c.reverse! if @value.to_s == 'desc' }
      end

      private

      def case_insensitive?(value)
        # Cannot sort pure Booleans or Nils, so we _must_ cast to Strings
        return true if value.is_a?(TrueClass) || value.is_a?(FalseClass)
        return true if value.is_a?(NilClass)
        @structure_path.operator.to_s == 'i'
      end

      def insensify(value)
        value.to_s.downcase
      end
    end
  end
end
