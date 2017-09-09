# frozen_string_literal: true

require_relative '../base_adapter'

class ActiveSet
  module Filter
    class EnumerableAdapter < BaseAdapter
      def process(set)
        @set = set
        @set.select { |item| item.send(@key) == @value }
      end
    end
  end
end
