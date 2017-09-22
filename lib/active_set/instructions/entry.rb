# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'

require_relative 'entry/keypath'
require_relative 'entry/value'

class ActiveSet
  class Instructions
    class Entry
      attr_reader :keypath

      delegate :path, :attribute, :operator, :associations_array,
               :associations_hash, :value_for, :resource_for,
               to: :keypath

      def initialize(keypath, value)
        @keypath = KeyPath.new(keypath)
        @value = Value.new(value)
      end

      def value
        @value.raw
      end
    end
  end
end
