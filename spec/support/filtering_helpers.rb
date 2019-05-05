# frozen_string_literal: true

module FilteringHelpers
  def filter_value_for(object:, path:)
    value_for(object: object, path: path)
  end
end
