# frozen_string_literal: true

require_relative '../base_processor'
require_relative './enumerable_adapter'

class ActiveSet
  module Filter
    class Processor < BaseProcessor
      def process
        @structure.reject { |_, v| v.blank? }
                  .reduce(@set) do |set, (key, value)|
                    adapter.new(key, value).process(set)
                  end
      end

      private

      def adapter
        EnumerableAdapter
      end
    end
  end
end
