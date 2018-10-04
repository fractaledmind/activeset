# frozen_string_literal: true

require_relative '../patches/core_ext/hash/flatten_keys'
require_relative './instruction'

class ActiveSet
  class Instructions
    include Enumerable

    def initialize(hash)
      @instructions = hash.flatten_keys.map do |keypath, value|
        Instruction.new(keypath, value)
      end
    end

    def each(&block)
      @instructions.each(&block)
    end

    # :nocov:
    def method_missing(method_name, *args, &block)
      @instructions.send(method_name, *args, &block) || super
    end
    # :nocov:

    # :nocov:
    def respond_to_missing?(method_name, include_private = false)
      @instructions.respond_to?(method_name) || super
    end
    # :nocov:

    def associations_hash
      @instructions.reduce({}) { |h, i| h.merge(i.associations_hash) }
    end

    def get(key)
      @instructions.find do |instruction|
        instruction.attribute.to_s == key.to_s
      end&.value
    end
  end
end
