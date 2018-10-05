# frozen_string_literal: true

require 'active_support/core_ext/hash/reverse_merge'
require 'patches/core_ext/hash/flatten_keys'
require 'helpers/throws'
require 'active_set/attribute_instruction'
require 'active_set/filtering/operation'
require 'active_set/sorting/operation'
require 'active_set/paginating/operation'
# require 'active_set/transforming/operation'

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

  # :nocov:
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
  # :nocov:

  def filter(instructions_hash)
    filterer = Filtering::Operation.new(@view, instructions_hash)
    reinitialize(filterer.execute, :filter, instructions_hash)
  end

  def sort(instructions_hash)
    sorter = Sorting::Operation.new(@view, instructions_hash)
    reinitialize(sorter.execute, :sort, instructions_hash)
  end

  def paginate(instructions_hash)
    paginater = Paginating::Operation.new(@view, instructions_hash)
    full_instructions_hash = instructions_hash.reverse_merge(paginater.operation_instructions)
    reinitialize(paginater.execute, :paginate, full_instructions_hash)
  end

  private

  def reinitialize(processed_set, method, instructions)
    self.class.new(@set,
                   view: processed_set,
                   instructions: @instructions.merge(
                     method => instructions))
  end
end
