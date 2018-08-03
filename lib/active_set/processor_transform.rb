# frozen_string_literal: true

require_relative './processor_base'
require_relative './processor_transform/csv_adapter'

class ActiveSet
  class Processor::Transform < Processor::Base
    def process
      fail "Format #{format} is not currently supported as option for tranform" unless %w[csv].include?(format)

      adapter = adapter_for(format: format)
      adapter.new(@set, columns).process
    end

    private

    def adapter_for(format:)
      return CSVAdapter if format == 'csv'
    end

    def format
      @instructions.get(:format).to_s.downcase
    end

    def columns
      @instructions.get(:columns)
    end
  end
end
