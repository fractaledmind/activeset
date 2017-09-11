# frozen_string_literal: true

require_relative '../base_adapter'

class ActiveSet
  class FilterProcessor < BaseProcessor
    class EnumerableAdapter < BaseAdapter
      def process(set)
        set.select do |item|
          attribute_value = @structure_path.value_for(item: item)
          attribute_value.send(@structure_path.operator,
                               @structure_value.cast(to: attribute_value.class))
        end
      end
    end
  end
end
