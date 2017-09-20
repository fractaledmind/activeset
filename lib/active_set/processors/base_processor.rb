# frozen_string_literal: true

require 'patches/core_ext/hash/flatten_keys'
require_relative '../instructions/base'

class ActiveSet
  class BaseProcessor
    def self.queue_adapter(adapter)
      @adapters ||= []
      @adapters |= [adapter]
    end

    def initialize(set, instructions)
      @set = set
      @instructions = Instructions.new(instructions)
    end

    def adapters
      self.class.instance_variable_get(:@adapters)
    end
  end
end
