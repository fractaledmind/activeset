# frozen_string_literal: true

class Foo < ApplicationRecord
  belongs_to :assoc

  scope :datetime_between, (lambda do |start, finish|
    where(Arel::Table.new(table_name)[:datetime].between(start..finish))
  end)

  scope :string_starts_with, (lambda do |substr|
    where(Arel::Table.new(table_name)[:string].matches("#{substr}%"))
  end)
end
