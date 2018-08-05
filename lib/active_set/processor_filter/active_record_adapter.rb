# frozen_string_literal: true

require_relative '../adapter_activerecord'
require_relative '../processor_base'
require_relative '../../helpers/throws'

class ActiveSet
  class Processor::Filter < Processor::Base
    class ActiveRecordAdapter < Adapter::ActiveRecord
      def process
        return false unless @set.respond_to?(:to_sql)

        if can_query_with_active_record?
          statement = arel_eager_load_associations
                        .where(arel_operation)
        elsif can_merge_with_active_record?
          statement = arel_eager_load_associations
                        .merge(attribute_model.public_send(instruction.attribute,
                                                           instruction.value))
        else
          return false
        end

        return false if throws?(ActiveRecord::StatementInvalid) { statement.load }

        statement
      end

      private

      def instruction
        @instructions.first
      end

      def arel_operation
        Arel::Nodes::InfixOperation.new(arel_operator,
                                        arel_column,
                                        arel_value)
      end

      def arel_value
        Arel.sql(ActiveRecord::Base.connection.quote(instruction.value))
      end

      def arel_operator
        instruction.operator
      end
    end
  end
end
