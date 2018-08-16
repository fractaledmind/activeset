# frozen_string_literal: true

require_relative '../adapter_activerecord'
require_relative '../processor_base'
require_relative '../../helpers/throws'

class ActiveSet
  class Processor::Sort < Processor::Base
    class ActiveRecordAdapter < Adapter::ActiveRecord
      def process
        @instructions.reduce(@set) do |set, _instruction|
          # set Adapter::Base#instruction, which many methods depend on
          self.instruction = _instruction

          return false unless @set.respond_to?(:to_sql)
          return false unless can_query_with_active_record?

          statement = arel_eager_load_associations
                        .merge(arel_operation)

          return false if throws?(ActiveRecord::StatementInvalid) { statement.load }

          statement
        end
      end

      private

      def arel_operation
        arel_direction = arel_direction(instruction.value)

        attribute_model.order(arel_column.send(arel_direction))
      end

      def arel_column
        case_insensitive? ? super.lower : super
      end

      def case_insensitive?
        instruction.operator.to_s.downcase == 'i'
      end

      def arel_direction(direction)
        return 'desc' if direction.to_s.downcase.start_with? 'desc'

        'asc'
      end
    end
  end
end
