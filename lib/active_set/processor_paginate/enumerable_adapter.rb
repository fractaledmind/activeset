# frozen_string_literal: true

require_relative '../adapter_base'
require_relative '../processor_base'

class ActiveSet
  class Processor::Paginate < Processor::Base
    class EnumerableAdapter < Adapter::Base
      def process
        return [] if @set.count <= page_size && page_number > 1

        @set[page_start..page_end] || []
      end

      private

      def page_start
        return 0 if page_number == 1

        page_size * (page_number - 1)
      end

      def page_end
        return page_start if page_size == 1

        page_start + page_size - 1
      end

      def page_size
        @instructions.get('size').to_i
      end

      def page_number
        num = @instructions.get('page').to_i
        (num.to_i - 1).negative? ? 0 : num
      end
    end
  end
end
