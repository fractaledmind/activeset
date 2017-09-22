# frozen_string_literal: true

require_relative '../base_adapter'

class ActiveSet
  class FilterProcessor < BaseProcessor
    class EnumerableAdapter < BaseAdapter
      def process
        return_set(filtered_set)
      end

      private

      def filtered_set
        @set.select do |item|
          select_comparison_for(item: item)
        end
      end

      def select_comparison_for(item:)
        @instruction.value_for(item: item)
                    .send(@instruction.operator,
                          @instruction.value)
      end
    end
  end
end
