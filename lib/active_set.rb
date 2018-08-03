# frozen_string_literal: true

require 'active_set/version'

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

  def each(&block)
    @view.each(&block)
  end

  def ==(other)
    return @view == other unless other.is_a?(ActiveSet)
    @view == other.view
  end

  def method_missing(method_name, *args, &block)
    @view.send(method_name, *args, &block) || super
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
    reinitialize(paginater.process, :paginate, instructions)
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
