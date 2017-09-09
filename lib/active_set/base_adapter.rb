# frozen_string_literal: true

require_relative './structure_path'

class BaseAdapter
  def initialize(keypath, value)
    @structure_path = StructurePath.new(keypath)
    @value = value
  end
end
