# frozen_string_literal: true

require 'active_set/version'

require 'active_set/processors/filter_processor'
require 'active_set/processors/sort_processor'
require 'active_set/processors/paginate_processor'
require 'active_set/processors/transform_processor'

class ActiveSet
  include Enumerable

  attr_reader :set, :instructions, :total_count

  def initialize(set, instructions: {}, total_count: nil)
    @set = set
    @instructions = instructions
    @total_count = total_count || @set.count
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
    self.class.new(filterer.process,
                   instructions: @instructions.merge(filter: instructions),
                   total_count: @total_count)
  end

  def sort(instructions)
    sorter = SortProcessor.new(@set, instructions)
    self.class.new(sorter.process,
                   instructions: @instructions.merge(sort: instructions),
                   total_count: @total_count)
  end

  def paginate(instructions)
    paginater = PaginateProcessor.new(@set, instructions)
    self.class.new(paginater.process,
                   instructions: @instructions.merge(paginate: instructions),
                   total_count: @total_count)
  end

  def transform(instructions)
    transformer = TransformProcessor.new(@set, instructions)
    transformer.process
  end
end
