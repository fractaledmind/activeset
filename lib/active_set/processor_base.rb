# frozen_string_literal: true

require_relative './instructions'

class ActiveSet
  module Processor
    class Base
      attr_reader :set, :instructions, :adapters

      def self.register_adapter(adapter, precedence = 0)
        @adapters ||= []
        @adapters.insert(precedence, adapter)
      end

      def initialize(set, instructions)
        @set = set
        @instructions = Instructions.new(validate_instructions(instructions))
        @adapters = self.class.instance_variable_get(:@adapters)
      end

      private

      def validate_instructions(instructions)
        instructions
      end
    end
  end
end
