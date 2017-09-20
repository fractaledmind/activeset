# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

require_relative './base_processor'
require_relative './filter/enumerable_adapter'
require_relative './filter/active_record_adapter'

class ActiveSet
  class FilterProcessor < BaseProcessor
    queue_adapter ActiveRecordAdapter
    queue_adapter EnumerableAdapter

    def process
      adapters.reduce(@set) do |outer_set, adapter|
        @instructions.process_adapter(set: outer_set, adapter: adapter)
      end
    end
  end
end
