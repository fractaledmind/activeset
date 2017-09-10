# frozen_string_literal: true

class Widget < ApplicationRecord
  POSSIBLE_COLORS = %w[red orange yellow green blue indigo violet].freeze

  belongs_to  :customer
  has_many    :sources

  validates :quantity,
            presence: true
  validates :color,
            presence: true,
            inclusion: { in: POSSIBLE_COLORS }

  scope :ship_before, ->(value) { where("#{table_name}.ship_by <= ?", value) }
  scope :ship_after,  ->(value) { where("#{table_name}.ship_by >= ?", value) }

  def calculated_string_field
    color.reverse
  end

  def calculated_integer_field
    quantity * quantity
  end

  def calculated_relationship
    customer.owner
  end
end
