# frozen_string_literal: true

require 'active_set/version'

class ActiveSet
  include Enumerable

  def initialize(set)
    @set = set
  end

  def each(&block)
    @set.each(&block)
  end

  def filter(structure)
    structure.reject { |_, value| value.nil? || value.empty? }
             .reduce(@set) do |set, (key, value)|
               set.select { |item| item.send(key) == value }
             end
  end
end
