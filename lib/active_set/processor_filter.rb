# frozen_string_literal: true

require_relative './processor_base'
require_relative './processor_filter/enumerable_adapter'
require_relative './processor_filter/active_record_adapter'

class ActiveSet
  class Processor::Filter < Processor::Base
    def process
      @instructions.reduce(@set) do |set, instruction|
        adapters.each do |adapter|
          result = adapter.new(set, [instruction]).process
          break(result) if result
        end
      end
    end

    register_adapter(EnumerableAdapter)
    register_adapter(ActiveRecordAdapter)
  end
end
