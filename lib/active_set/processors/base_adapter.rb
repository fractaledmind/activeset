# frozen_string_literal: true

require_relative '../structure/path'
require_relative '../structure/value'

class BaseAdapter
  def initialize(keypath, value)
    @structure_path = Structure::Path.new(keypath)
    @structure_value = Structure::Value.new(value)
  end
end
