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

  def sort(structure)
    structure.reject { |_, value| value.nil? || value.empty? }
             .reduce(@set) do |set, (key, value)|
               set.sort_by { |item| item.send(key) }
                  .tap     { |c| c.reverse! if value.to_s == 'desc' }
             end
  end
end
