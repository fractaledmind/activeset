# frozen_string_literal: true

require 'csv'
require 'active_support/core_ext/hash/indifferent_access'

require_relative '../base_adapter'
require_relative '../base_processor'

class ActiveSet
  class TransformProcessor < BaseProcessor
    class CSVAdapter < BaseAdapter
      def process
        return_set(transformed_set)
      end

      private

      def transformed_set
        ::CSV.generate do |output|
          output << column_keys_for(item: @set.first)
          @set.each do |item|
            output << column_values_for(item: item)
          end
        end
      end

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
        @instruction.compact
      end

      class ColumnInstruction
        def initialize(hash, item)
          @hash = hash.with_indifferent_access
          @item = item
        end

        def key
          return @hash[:key] if @hash.key? :key
          return attribute_model.human_attribute_name(instruction_entry.attribute) if attribute_model.respond_to? :human_attribute_name
          instruction_entry.titleized
        end

        def value
          return blank unless @hash.key?(:value)
          return @hash[:value].call(@item) if @hash[:value]&.respond_to? :call
          instruction_entry.value_for(item: @item)
        end

        private

        def instruction_entry
          Instructions::Entry.new(@hash[:value], nil)
        end

        def attribute_model
          instruction_entry.associations_array
                           .reduce(@item) do |obj, assoc|
                             obj&.send(assoc)
                           end.class
        end

        def blank
          '—'
        end
      end
    end
  end
end
