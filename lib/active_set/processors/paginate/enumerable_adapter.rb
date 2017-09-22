# frozen_string_literal: true

require_relative '../base_adapter'
require_relative '../base_processor'

class ActiveSet
  class PaginateProcessor < BaseProcessor
    class EnumerableAdapter < BaseAdapter
      def process
        return return_set if @set.count < pagesize
        return_set(paginated_set)
      end

      private

      def paginated_set
        @set.each_slice(pagesize).take(page_number).last
      end

      def pagesize
        @instruction.value
      end

      def page_number
        @instruction.attribute.to_i
      end
    end
  end
end
