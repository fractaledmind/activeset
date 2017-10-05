# frozen_string_literal: true

require_relative './base_processor'
require_relative './sort/enumerable_adapter'
require_relative './sort/active_record_adapter'

class ActiveSet
  class SortProcessor < BaseProcessor
    queue_adapter ActiveRecordAdapter
    queue_adapter EnumerableAdapter

    def process
      adapters.reduce(@set) do |outer_set, adapter|
        @instructions.process_adapter(set: outer_set, adapter: adapter)
      end
    end
  end
end
