# frozen_string_literal: true

require_relative '../adapter_activerecord'
require_relative '../processor_base'
require_relative '../../helpers/throws'
require_relative './active_record_operation'

class ActiveSet
  class Processor::Sort < Processor::Base
    class ActiveRecordAdapter < Adapter::ActiveRecord
      def process
        return false unless @set.respond_to?(:to_sql)

        @instructions.reduce(@set.eager_load(@instructions.associations_hash)) do |set, instruction|
          ar_operation = ActiveRecordOperation.new(instruction, @set.klass)
          return false unless ar_operation.attribute_is_field?

          statement = set.merge(ar_operation.operation)

          return false if throws?(ActiveRecord::StatementInvalid) { statement.load }

          statement
        end
      end
    end
  end
end
