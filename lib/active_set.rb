# frozen_string_literal: true

require 'active_set/version'

require 'active_set/processors/filter_processor'
require 'active_set/processors/sort_processor'
require 'active_set/processors/paginate_processor'

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

  def method_missing(method_name, *args, &block)
    @set.send(method_name, *args, &block) || super
  end

  def respond_to_missing?(method_name, include_private = false)
    @set.respond_to?(method_name) || super
  end

  def filter(instructions)
    filterer = FilterProcessor.new(@set, instructions)
    self.class.new(filterer.process)
  end

  def sort(instructions)
    sorter = SortProcessor.new(@set, instructions)
    self.class.new(sorter.process)
  end

  def paginate(instructions)
    paginater = PaginateProcessor.new(@set, instructions)
    self.class.new(paginater.process)
  end
end
