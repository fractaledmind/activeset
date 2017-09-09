# frozen_string_literal: true

require_relative '../base_adapter'

class ActiveSet
  module Paginate
    class EnumerableAdapter < BaseAdapter
      def process(set)
        @set = set
        @set.each_slice(pagesize).take(page_number).last
      end

      private

      def pagesize
        @value
      end

      def page_number
        @key
      end
    end
  end
end
