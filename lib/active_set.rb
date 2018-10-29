# frozen_string_literal: true

require 'active_set/version'

require 'active_support/core_ext/hash/reverse_merge'
require 'active_set/processor_filter'
require 'active_set/processor_sort'
require 'active_set/processor_paginate'
require 'active_set/processor_transform'

class ActiveSet
  include Enumerable

  attr_reader :set, :view, :instructions

  def initialize(set, view: nil, instructions: {})
    @set = set
    @view = view || set
    @instructions = instructions
  end

  def inspect
    "#<ActiveSet:#{"0x00%x" % (object_id << 1)} @instructions=#{@instructions.inspect}>"
  end

  def each(&block)
    @view.each(&block)
  end

  def ==(other)
    return @view == other unless other.is_a?(ActiveSet)
    @view == other.view
  end

  def method_missing(method_name, *args, &block)
    return @view.send(method_name, *args, &block) if @view.respond_to?(method_name)

    super
  end

  def respond_to_missing?(method_name, include_private = false)
    @view.respond_to?(method_name) || super
  end

  def filter(instructions)
    filterer = Processor::Filter.new(@view, instructions)
    reinitialize(filterer.process, :filter, instructions)
  end

  def sort(instructions)
    sorter = Processor::Sort.new(@view, instructions)
    reinitialize(sorter.process, :sort, instructions)
  end

  def paginate(instructions)
    paginater = Processor::Paginate.new(@view, instructions)
    full_instructions = instructions.reverse_merge(page: paginater.instructions.get(:page),
                                                   size: paginater.instructions.get(:size))
    reinitialize(paginater.process, :paginate, full_instructions)
  end

  def transform(instructions)
    transformer = Processor::Transform.new(@view, instructions)
    transformer.process
  end

  private

  def reinitialize(processed_set, method, instructions)
    self.class.new(@set,
                   view: processed_set,
                   instructions: @instructions.merge(
                     method => instructions))
  end
end
