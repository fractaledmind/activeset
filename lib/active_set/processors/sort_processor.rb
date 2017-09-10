# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

require_relative './base_processor'
require_relative './sort/enumerable_adapter'
require_relative './sort/active_record_adapter'

class ActiveSet
  class SortProcessor < BaseProcessor
    queue_adapter ActiveRecordAdapter
    queue_adapter EnumerableAdapter

    def process
      adapters.reduce(@set) do |outer_set, adapter|
        @structure.reject { |_, v| v.blank? }
                  .reduce(outer_set) do |inner_set, (keypath, value)|
                    adapter.new(keypath, value).process(inner_set)
                  end
      end
    end
  end
end
