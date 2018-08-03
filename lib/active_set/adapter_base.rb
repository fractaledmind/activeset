# frozen_string_literal: true

class ActiveSet
  module Adapter
    class Base
      def initialize(set, instructions)
        @set = set
        @instructions = instructions
      end
    end
  end
end
