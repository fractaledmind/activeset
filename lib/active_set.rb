# frozen_string_literal: true

require 'active_set/version'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/slice'

require 'active_set/filter_processor'
require 'active_set/sort_processor'
require 'active_set/paginate_processor'

class ActiveSet
  include Enumerable

  attr_reader :set

  def initialize(set)
    @set = set
  end

  def each(&block)
    @set.each(&block)
  end

  def ==(other)
    return @set == other unless other.is_a?(ActiveSet)
    @set == other.set
  end

  def filter(structure)
    filterer = FilterProcessor.new(@set, structure)
    self.class.new(filterer.process)
  end

  def sort(structure)
    sorter = SortProcessor.new(@set, structure)
    self.class.new(sorter.process)
  end

  def paginate(structure)
    paginater = PaginateProcessor.new(@set, structure)
    self.class.new(paginater.process)
  end
end
