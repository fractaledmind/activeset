# frozen_string_literal: true

require_relative './base_processor'

class SortProcessor < BaseProcessor
  def process
    @structure.reject { |_, value| value.blank? }
              .reduce(@set) do |set, (key, value)|
                set.sort_by { |item| item.send(key) }
                   .tap     { |c| c.reverse! if value.to_s == 'desc' }
              end
  end
end
