# frozen_string_literal: true

require_relative '../adapter_base'

class ActiveSet
  class Processor::Filter < Processor::Base
    class EnumerableAdapter < Adapter::Base
      def process
        return false unless @set.respond_to? :select

        @instructions.reduce(@set) do |set, instruction|
          set.select do |item|
            instruction.value_for(item: item)
                       .send(instruction.operator,
                             instruction.value)
          end
        end
      end
    end
  end
end
