# frozen_string_literal: true

require_relative './base_processor'
require_relative './transform/csv_adapter'

class ActiveSet
  class TransformProcessor < BaseProcessor
    def process
      adapter_for(format: format).new(@set, columns).process
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
