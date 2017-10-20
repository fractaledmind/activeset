# frozen_string_literal: true

require_relative './base_processor'
require_relative './transform/csv_adapter'

class ActiveSet
  class TransformProcessor < BaseProcessor
    def process
      fail "Format #{format} is not currently supported as option for tranform" unless %w[csv].include?(format)

      adapter = adapter_for(format: format)
      output = adapter.new(@set, columns).process
      output[:set]
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
