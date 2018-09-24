# frozen_string_literal: true

require_relative '../adapter_activerecord'
require_relative '../processor_base'
require_relative '../../helpers/throws'

class ActiveSet
  class Processor::Sort < Processor::Base
    class ActiveRecordOperation
      def initialize(instruction, klass)
        @instruction = instruction
        @klass = klass
      end

      def operation
        attribute_model.order(column.send(validate_direction(@instruction.value)))
      end

      def attribute_is_field?
        return false unless attribute_model

        attribute_model.attribute_names
                       .include?(@instruction.attribute)
      end

      def case_insensitive?
        @instruction.operator.to_s.downcase == 'i'
      end

      def column
        column = table[@instruction.attribute]
        case_insensitive? ? column.lower : column
      end

      def table
        Arel::Table.new(attribute_model.table_name)
      end

      def validate_direction(direction)
        return 'desc' if direction.to_s.downcase.start_with? 'desc'

        'asc'
      end

      def attribute_model
        tmp_model = @instruction.associations_array
                                .reduce(@klass) do |obj, assoc|
                                  obj.reflections[assoc.to_s]&.klass
                                end
        # return tmp_model.klass if tmp_model.is_a?(ActiveRecord::Relation)
        # tmp_model
      end
    end
  end
end
