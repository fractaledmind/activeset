# frozen_string_literal: true

require_relative './processor_base'
require_relative './processor_sort/enumerable_adapter'
require_relative './processor_sort/active_record_adapter'

class ActiveSet
  class Processor::Sort < Processor::Base
    def process
      adapters.each do |adapter|
        result = adapter.new(@set, @instructions).process
        break(result) if result
      end
    end

    register_adapter(EnumerableAdapter)
    register_adapter(ActiveRecordAdapter)
  end
end
