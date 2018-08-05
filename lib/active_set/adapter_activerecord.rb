# frozen_string_literal: true

require_relative './adapter_base'

class ActiveSet
  class Adapter::ActiveRecord < Adapter::Base
    private

    def can_query_with_active_record?
      attribute_is_field?
    end

    def can_merge_with_active_record?
      attribute_is_class_method? &&
        attribute_is_method_with_params?
    end

    def arel_eager_load_associations
      @set.eager_load(instruction.associations_hash)
    end

    def arel_column
      arel_table[instruction.attribute]
    end

    def arel_table
      Arel::Table.new(attribute_model.table_name)
    end

    def attribute_is_field?
      return false unless attribute_model

      attribute_model.attribute_names
                     .include?(instruction.attribute)
    end

    def attribute_is_class_method?
      return false unless attribute_model

      attribute_model.respond_to?(instruction.attribute)
    end

    def attribute_is_method_with_params?
      return false unless attribute_model

      attribute_model.method(instruction.attribute).arity != 0
    end

    def attribute_model
      tmp_model = instruction.associations_array
                             .reduce(@set) do |obj, assoc|
                               obj.reflections[assoc.to_s]&.klass
                             end
      # return tmp_model.klass if tmp_model.is_a?(ActiveRecord::Relation)
      # tmp_model
    end
  end
end
