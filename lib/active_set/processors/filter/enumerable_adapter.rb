# frozen_string_literal: true

require_relative '../base_adapter'

class ActiveSet
  class FilterProcessor < BaseProcessor
    class EnumerableAdapter < BaseAdapter
      def process(set)
        set.select do |item|
          @instruction.value_for(item: item)
                      .send(@instruction.operator,
                            @instruction.value)
        end
      end
    end
  end
end
