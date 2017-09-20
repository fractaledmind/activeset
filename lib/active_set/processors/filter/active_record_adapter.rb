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
                       .include?(@instruction.attribute)
      end

      def query
        @set.includes(@instruction.associations_hash)
            .references(@instruction.associations_hash)
            .where(arel_operation)
      end

      def arel_operation
        Arel::Nodes::InfixOperation.new(@instruction.operator,
                                        arel_column,
                                        arel_value)
      end

      def attribute_model
        @instruction.associations_array
                    .reduce(@set) do |obj, assoc|
                      obj.reflections[assoc.to_s]&.klass
                    end
      end

      def arel_column
        arel_table[@instruction.attribute]
      end

      def arel_value
        Arel.sql(ActiveRecord::Base.connection.quote(@instruction.value))
      end

      def arel_table
        Arel::Table.new(attribute_model.table_name)
      end
    end
  end
end
