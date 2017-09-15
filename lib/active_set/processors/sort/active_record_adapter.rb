# frozen_string_literal: true

require_relative '../base_adapter'
require_relative '../base_processor'

class ActiveSet
  class SortProcessor < BaseProcessor
    class ActiveRecordAdapter < BaseAdapter
      def process(set)
        @set = set
        return @set unless @set.respond_to? :to_sql
        return @set unless attribute_is_field?

        @set.includes(@structure_path.to_h)
            .references(@structure_path.to_h)
            .merge(arel_operation)
      end

      private

      def attribute_is_field?
        return false unless attribute_model
        attribute_model.attribute_names
                       .include?(@structure_path.attribute)
      end

      def case_insensitive?
        @structure_path.operator.to_s == 'i'
      end

      def arel_operation
        column = case_insensitive? ? arel_column.lower : arel_column
        attribute_model.order(column.send(@value))
      end

      def attribute_model
        @structure_path.to_a
                       .reduce(@set) do |obj, assoc|
                         obj.reflections[assoc.to_s]&.klass
                       end
      end

      def arel_column
        arel_table[@structure_path.attribute]
      end

      def arel_table
        Arel::Table.new(attribute_model.table_name)
      end
    end
  end
end
