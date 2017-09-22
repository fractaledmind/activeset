# frozen_string_literal: true

require_relative './base_processor'
require_relative './paginate/enumerable_adapter'

class ActiveSet
  class PaginateProcessor < BaseProcessor
    def process
      adapter.new(@set, instruction).process
    end

    private

    def adapter
      EnumerableAdapter
    end

    def instruction
      Instructions::Entry.new(page_number, pagesize)
    end

    def page_number
      @instructions.get(:page) || 1
    end

    def pagesize
      @instructions.get(:size) || 25
    end
  end
end
