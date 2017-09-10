# frozen_string_literal: true

FactoryGirl.define do
  factory :source do
    name         { Faker::GameOfThrones.house }

    widget
  end
end
