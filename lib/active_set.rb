# frozen_string_literal: true

require 'active_set/version'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/slice'

require 'active_set/filter/processor'
require 'active_set/sort/processor'
require 'active_set/paginate/processor'

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
    filterer = Filter::Processor.new(@set, structure)
    self.class.new(filterer.process)
  end

  def sort(structure)
    sorter = Sort::Processor.new(@set, structure)
    self.class.new(sorter.process)
  end

  def paginate(structure)
    paginater = Paginate::Processor.new(@set, structure)
    self.class.new(paginater.process)
  end
end
