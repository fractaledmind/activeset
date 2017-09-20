# frozen_string_literal: true

require_relative './entry'

class ActiveSet
  class Instructions
    attr_reader :hash

    def initialize(hash)
      @hash = hash
      @flattened_hash = hash.flatten_keys
    end

    def process_adapter(set:, adapter:)
      @flattened_hash.reject { |_, v| v.blank? }
                     .reduce(set) do |inner_set, (keypath, value)|
                       instruction = Entry.new(keypath, value)
                       adapter.new(instruction).process(inner_set)
                     end
    end

    def get(keypath)
      @hash.dig(*keypath)
    end
  end
end
