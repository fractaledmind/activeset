# frozen_string_literal: true

require_relative '../base_adapter'

class ActiveSet
  module Sort
    class EnumerableAdapter < BaseAdapter
      def process(set)
        @set = set
        @set.sort_by do |item|
          attribute_value = @structure_path.value_for(item: item)
          attribute_value.is_a?(String) ? attribute_value.downcase : attribute_value
        end.tap { |c| c.reverse! if @value.to_s == 'desc' }
      end
    end
  end
end
