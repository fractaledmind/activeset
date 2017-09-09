# frozen_string_literal: true

require_relative './base_processor'

class FilterProcessor < BaseProcessor
  def process
    @structure.reject { |_, value| value.blank? }
              .reduce(@set) do |set, (key, value)|
                set.select { |item| item.send(key) == value }
              end
  end
end
