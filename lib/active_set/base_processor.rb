# frozen_string_literal: true

require 'patches/core_ext/hash/flatten_keys'

class BaseProcessor
  def initialize(set, structure)
    @set = set
    @structure = structure.flatten_keys
  end
end
