# frozen_string_literal: true

require_relative '../base_adapter'
require_relative '../base_processor'

class ActiveSet
  class PaginateProcessor < BaseProcessor
    class EnumerableAdapter < BaseAdapter
      def process
        return_set(paginated_set)
      end

      private

      def paginated_set
        return [] if @set.count <= page_size && page_number > 1

        @set[page_start..page_end] || []
      end

      def page_start
        return 0 if page_number == 1
        page_size * (page_number - 1)
      end

      def page_end
        return page_start if page_size == 1
        page_start + page_size - 1
      end

      def page_size
        @instruction.value
      end

      def page_number
        num = @instruction.attribute.to_i
        (num.to_i - 1).negative? ? 0 : num
      end
    end
  end
end
