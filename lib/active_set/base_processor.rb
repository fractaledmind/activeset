# frozen_string_literal: true

require 'patches/core_ext/hash/flatten_keys'

class BaseProcessor
  def self.queue_adapter(adapter)
    @adapters ||= []
    @adapters |= [adapter]
  end

  def initialize(set, structure)
    @set = set
    @structure = structure.flatten_keys
  end

  def adapters
    self.class.instance_variable_get(:@adapters)
  end
end
