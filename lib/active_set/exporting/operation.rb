# frozen_string_literal: true

require_relative '../column_instruction'

module Exporting
  class Operation
    def initialize(set, instructions_hash)
      @set = set
      @instructions_hash = instructions_hash
    end

    def execute
      strategy_for(format: operation_instructions[:format].to_s.downcase)
        .new(@set, operation_instructions[:columns])
        .execute
    end

    def operation_instructions
      @instructions_hash.symbolize_keys
    end

    private

    def strategy_for(format:)
      return CSVStrategy if format == 'csv'
    end
  end

  class CSVStrategy
    require 'csv'

    def initialize(set, column_instructions)
      @set = set
      @column_instructions = column_instructions
    end

    def execute
      ::CSV.generate do |output|
        output << column_keys_for(item: @set.first)
        @set.each do |item|
          output << column_values_for(item: item)
        end
      end
    end

    private

    def column_keys_for(item:)
      columns.map do |column|
        ColumnInstruction.new(column, item).key
      end
    end

    def column_values_for(item:)
      columns.map do |column|
        ColumnInstruction.new(column, item).value
      end
    end

    def columns
      @column_instructions.compact
    end
  end
end
