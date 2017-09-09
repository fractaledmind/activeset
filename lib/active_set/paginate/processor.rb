# frozen_string_literal: true

require_relative '../base_processor'
require_relative './enumerable_adapter'

class ActiveSet
  module Paginate
    class Processor < BaseProcessor
      def process
        return @set if @set.count < pagesize
        adapter.new(@structure[:page], pagesize).process(@set)
      end

      private

      def adapter
        EnumerableAdapter
      end

      def pagesize
        @structure[:size] || 25
      end
    end
  end
end
