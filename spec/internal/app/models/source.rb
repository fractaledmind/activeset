# frozen_string_literal: true

class Source < ApplicationRecord
  belongs_to :widget

  def calculated_string_field
    name.reverse
  end
end
