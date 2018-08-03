# frozen_string_literal: true

require_relative '../adapter_base'
require_relative '../processor_base'

class ActiveSet
  class Processor::Paginate < Processor::Base
    class ActiveRecordAdapter < Adapter::Base
      def process
        return false unless @set.respond_to? :to_sql
        return @set.none if @set.length <= page_size && page_number > 1

        @set.limit(page_size).offset(page_offset)
      end

      private

      def page_offset
        return 0 if page_number == 1

        page_size * (page_number - 1)
      end

      def page_size
        @instructions.get('size').to_i
      end

      def page_number
        num = @instructions.get('page').to_i
        return 1 if (num - 1).negative?
        return 1 if (num - 1).zero?

        num
      end
    end
  end
end
