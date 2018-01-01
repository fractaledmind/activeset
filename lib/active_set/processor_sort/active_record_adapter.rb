# frozen_string_literal: true

require_relative '../adapter_activerecord'
require_relative '../processor_base'
require_relative '../../helpers/throws'

class ActiveSet
  class Processor::Sort < Processor::Base
    class ActiveRecordAdapter < Adapter::ActiveRecord
      def process
        @instructions.reduce(@set) do |set, instruction|
          # set Adapter::Base#instruction, which many methods depend on
          self.instruction = instruction

          return false unless can_process_with_active_record?

          statement = set.includes(instruction.associations_hash)
                         .references(instruction.associations_hash)
                         .merge(arel_operation)

          return false if throws?(ActiveRecord::StatementInvalid) { statement.load }

          statement
        end
      end

      private

      def arel_operation
        column = case_insensitive? ? arel_column.lower : arel_column

        attribute_model.order(column.send(instruction.value))
      end

      def case_insensitive?
        instruction.operator.to_s.downcase == 'i'
      end
    end
  end
end
