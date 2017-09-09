# frozen_string_literal: true

require_relative '../base_adapter'

class ActiveSet
  module Sort
    class EnumerableAdapter < BaseAdapter
      def process(set)
        @set = set
        @set.sort_by { |item| item.send(@key) }
            .tap     { |c| c.reverse! if @value.to_s == 'desc' }
      end
    end
  end
end
