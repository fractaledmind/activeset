# frozen_string_literal: true

require_relative '../base_adapter'
require_relative '../base_processor'

class ActiveSet
  class FilterProcessor < BaseProcessor
    class ActiveRecordAdapter < BaseAdapter
      def process
        return return_set unless @set.respond_to? :to_sql
        return return_set(processed_query_set) if attribute_is_field?
        return return_set(processed_scope_set) if attribute_is_class_method? && attribute_is_method_with_params?

        return_set
      end

      private

      def processed_query_set
        arel_eager_load_associations.where(arel_operation)
      end

      def processed_scope_set
        tmp_results = attribute_model.public_send(@instruction.attribute, @instruction.value)
        return @set unless tmp_results.is_a?(ActiveRecord::Relation)
        arel_eager_load_associations.merge(tmp_results)
      end

      def attribute_is_field?
        return false unless attribute_model
        attribute_model.attribute_names
                       .include?(@instruction.attribute)
      end

      def attribute_is_class_method?
        return false unless attribute_model
        attribute_model.respond_to?(@instruction.attribute)
      end

      def attribute_is_method_with_params?
        return false unless attribute_model
        attribute_model.method(@instruction.attribute).arity != 0
      end

      def arel_operation
        Arel::Nodes::InfixOperation.new(@instruction.operator,
                                        arel_column,
                                        arel_value)
      end

      def attribute_model
        tmp_model = @instruction.associations_array
                                .reduce(@set) do |obj, assoc|
                                  obj.reflections[assoc.to_s]&.klass
                                end
        return tmp_model.klass if tmp_model.is_a?(ActiveRecord::Relation)
        tmp_model
      end

      def arel_eager_load_associations
        @set.includes(@instruction.associations_hash)
            .references(@instruction.associations_hash)
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
