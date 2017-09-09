# frozen_string_literal: true

require_relative '../base_adapter'

class ActiveSet
  module Filter
    class EnumerableAdapter < BaseAdapter
      def process(set)
        @set = set
        @set.select do |item|
          attribute_value = @structure_path.value_for(item: item)
          attribute_value.send(@structure_path.operator,
                               @value)
        end
      end
    end
  end
end
