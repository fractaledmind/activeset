# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

require_relative '../base_processor'
require_relative './enumerable_adapter'

class ActiveSet
  module Sort
    class Processor < BaseProcessor
      def process
        @structure.reject { |_, value| value.blank? }
                  .reduce(@set) do |set, (keypath, value)|
                    adapter.new(keypath, value).process(set)
                  end
      end

      private

      def adapter
        EnumerableAdapter
      end
    end
  end
end
