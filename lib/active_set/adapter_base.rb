# frozen_string_literal: true

class ActiveSet
  module Adapter
    class Base
      attr_accessor :instruction

      def initialize(set, instructions)
        @set = set
        @instructions = instructions
      end
    end
  end
end
