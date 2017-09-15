# frozen_string_literal: true

require_relative '../structure/path'

class BaseAdapter
  def initialize(keypath, value)
    @structure_path = Structure::Path.new(keypath)
    @value = value
  end
end
