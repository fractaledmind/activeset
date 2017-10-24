# frozen_string_literal: true

require_relative '../base_adapter'
require_relative '../base_processor'

class ActiveSet
  class PaginateProcessor < BaseProcessor
    class ActiveRecordAdapter < BaseAdapter
      def process
        return return_set unless @set.respond_to? :to_sql

        return_set(paginated_set)
      end

      private

      def paginated_set
        return @set.none if @set.count <= page_size && page_number > 1
        @set.limit(page_size).offset(page_offset)
      end

      def page_offset
        return 0 if page_number == 1
        page_size * page_number
      end

      def page_size
        @instruction.value
      end

      def page_number
        num = @instruction.attribute.to_i
        return 1 if (num - 1).negative?
        return 1 if (num - 1).zero?
        num
      end
    end
  end
end
