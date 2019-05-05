# frozen_string_literal: true

class Thing < ApplicationRecord
  belongs_to :one,
             optional: true
  has_many :alots,
           inverse_of: :thing
  has_many :relateds,
           through: :joint,
           inverse_of: :things
end
