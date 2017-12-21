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
    filtered_set = filterer.process
    new_active_set(filtered_set, :filter, instructions, filtered_set.count)
  end

  def sort(instructions)
    sorter = SortProcessor.new(@set, instructions)
    new_active_set(sorter.process, :sort, instructions)
  end

  def paginate(instructions)
    paginater = PaginateProcessor.new(@set, instructions)
    full_instructions = instructions.reverse_merge(page: paginater.send(:page_number),
                                                   size: paginater.send(:page_size))
    new_active_set(paginater.process, :paginate, full_instructions)
  end

  def transform(instructions)
    transformer = TransformProcessor.new(@set, instructions)
    transformer.process
  end

  private

  def new_active_set(set, method, instructions, total_count = nil)
    self.class.new(set,
                   instructions: @instructions.merge(method => instructions),
                   total_count: total_count || @total_count)
  end
end
