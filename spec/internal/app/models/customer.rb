# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :widgets

  belongs_to :state

  scope :birth_before, ->(value) { where("#{table_name}.birthdate <= ?", value) }
  scope :birth_after,  ->(value) { where("#{table_name}.birthdate >= ?", value) }

  def calculated_string_field
    name.reverse
  end

  def calculated_date_field
    birthdate + 1.year
  end
end
