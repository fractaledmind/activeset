# frozen_string_literal: true

require_relative './base_processor'
require_relative './paginate/enumerable_adapter'
require_relative './paginate/active_record_adapter'

class ActiveSet
  class PaginateProcessor < BaseProcessor
    queue_adapter ActiveRecordAdapter
    queue_adapter EnumerableAdapter

    def process
      adapters.each do |adapter|
        output = adapter.new(@set, instruction).process

        return output[:set] if output[:processed]
      end

      @set
    end

    private

    def instruction
      Instructions::Entry.new(page_number, page_size)
    end

    def page_number
      @instructions.get(:page) || 1
    end

    def page_size
      @instructions.get(:size) || 25
    end
  end
end
