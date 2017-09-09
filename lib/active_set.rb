# frozen_string_literal: true

require 'active_set/version'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/slice'

class ActiveSet
  include Enumerable

  def initialize(set)
    @set = set
  end

  def each(&block)
    @set.each(&block)
  end

  def filter(structure)
    self.class.new(structure.reject { |_, value| value.blank? }
                            .reduce(@set) do |set, (key, value)|
                              set.select { |item| item.send(key) == value }
                            end)
  end

  def sort(structure)
    self.class.new(structure.reject { |_, value| value.blank? }
                            .reduce(@set) do |set, (key, value)|
                              set.sort_by { |item| item.send(key) }
                                 .tap     { |c| c.reverse! if value.to_s == 'desc' }
                            end)
  end

  def paginate(structure)
    pagesize = structure[:size] || 25
    return self.class.new(@set) if @set.count < pagesize
    self.class.new(@set.each_slice(pagesize).take(structure[:page]).last)
  end
end
