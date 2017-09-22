# frozen_string_literal: true

class ActiveSet
  class BaseAdapter
    def initialize(set, instruction)
      @set = set
      @instruction = instruction
    end

    def return_set(set = nil)
      {}.tap do |h|
        h[:set] = set || @set
        h[:processed] = set ? true : false
      end
    end
  end
end
