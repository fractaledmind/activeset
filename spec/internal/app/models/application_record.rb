# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # computed attributes

  def computed_binary
    binary
  end

  def computed_boolean
    boolean
  end

  def computed_date
    date
  end

  def computed_datetime
    datetime
  end

  def computed_decimal
    decimal
  end

  def computed_float
    float
  end

  def computed_integer
    integer
  end

  def computed_string
    string
  end

  def computed_text
    text
  end

  def computed_time
    time
  end
end
