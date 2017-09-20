# frozen_string_literal: true

require_relative '../base_adapter'
require_relative '../base_processor'

class ActiveSet
  class PaginateProcessor < BaseProcessor
    class EnumerableAdapter < BaseAdapter
      def process(set)
        set.each_slice(pagesize).take(page_number).last
      end

      private

      def pagesize
        @instruction.value
      end

      def page_number
        @instruction.attribute.to_i
      end
    end
  end
end
