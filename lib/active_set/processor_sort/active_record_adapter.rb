# frozen_string_literal: true

require_relative '../adapter_activerecord'
require_relative '../processor_base'
require_relative '../../helpers/throws'

class ActiveSet
  class Processor::Sort < Processor::Base
    class ActiveRecordAdapter < Adapter::ActiveRecord
      def process
        return false unless can_process_with_active_record?

        statement = @set.includes(instruction.associations_hash)
                        .references(instruction.associations_hash)
                        .where(arel_operation)

        return false if throws?(ActiveRecord::StatementInvalid) { statement.load }

        statement
      end

      private

      def arel_operation
        attribute_model.order(arel_column.send(instruction.value))
      end
    end
  end
end
