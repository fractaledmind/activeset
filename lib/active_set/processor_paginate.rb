# frozen_string_literal: true

require_relative './processor_base'
require_relative './processor_paginate/enumerable_adapter'
require_relative './processor_paginate/active_record_adapter'

class ActiveSet
  class Processor::Paginate < Processor::Base
    def process
      adapters.each do |adapter|
        result = adapter.new(@set, @instructions).process
        break(result) if result
      end
    end

    private

    def validate_instructions(instructions)
      {
        page:   (instructions[:page] ||
                 instructions['page'] ||
                 1).to_i,
        size:   (instructions[:size] ||
                 instructions['size'] ||
                 25).to_i,
        outset: (instructions[:outset] ||
                 instructions['outset'] ||
                 0).to_i
      }
    end

    register_adapter(EnumerableAdapter)
    register_adapter(ActiveRecordAdapter)
  end
end
