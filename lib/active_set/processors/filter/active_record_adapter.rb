# frozen_string_literal: true

require_relative '../base_adapter'
require_relative '../base_processor'

class ActiveSet
  class FilterProcessor < BaseProcessor
    class ActiveRecordAdapter < BaseAdapter
      def process(set)
        @set = set
        return @set unless @set.respond_to? :to_sql
        return @set unless attribute_is_field?

        query
      end

      private

      def attribute_is_field?
        return false unless attribute_model
        attribute_model.attribute_names
                       .include?(@structure_path.attribute)
      end

      def query
        @set.includes(@structure_path.to_h)
            .references(@structure_path.to_h)
            .where(arel_operation)
      end

      def arel_operation
        Arel::Nodes::InfixOperation.new(@structure_path.operator,
                                        arel_column,
                                        arel_value)
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

      def arel_value
        Arel.sql(ActiveRecord::Base.connection.quote(@value))
      end

      def arel_table
        Arel::Table.new(attribute_model.table_name)
      end
    end
  end
end
