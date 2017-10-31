# frozen_string_literal: true

require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/indifferent_access'

require_relative './entry'

class ActiveSet
  class Instructions
    attr_reader :hash

    def initialize(hash)
      @hash = hash.with_indifferent_access
      @flattened_hash = hash.flatten_keys.transform_keys { |k| k.map(&:to_s) }
    end

    def process_adapter(set:, adapter:)
      @flattened_hash.reduce(set) do |inner_set, (keypath, value)|
        instruction = Entry.new(keypath, value)
        output = adapter.new(inner_set, instruction).process
        remove_from_instruction_set(key: instruction.path) if output[:processed]

        output[:set]
      end
    end

    def get(keypath)
      @hash.dig(*keypath)
    end

    private

    def remove_from_instruction_set(key:)
      @flattened_hash.delete(key)
    end
  end
end
