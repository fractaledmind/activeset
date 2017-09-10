# frozen_string_literal: true

class State < ApplicationRecord
  has_many :customers

  def calculated_string_field
    name.reverse
  end

  def calculated_integer_field
    latitude.to_s.reverse.to_i
  end
end
