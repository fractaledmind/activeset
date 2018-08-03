# frozen_string_literal: true

require_relative './adapter_base'

class ActiveSet
  class Adapter::ActiveRecord < Adapter::Base
    private

    def instruction
      @instructions.first
    end

    def can_process_with_active_record?
      @set.respond_to?(:to_sql) && attribute_is_field?
    end

    def arel_column
      arel_table[instruction.attribute]
    end

    def arel_table
      Arel::Table.new(attribute_model.table_name)
    end

    def attribute_is_field?
      attribute_model.attribute_names
                     .include?(instruction.attribute)
    end

    def attribute_model
      instruction.associations_array
                  .reduce(@set) do |obj, assoc|
                    obj.reflections[assoc.to_s]&.klass
                  end
    end
  end
end
