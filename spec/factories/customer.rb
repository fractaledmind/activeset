# frozen_string_literal: true

FactoryGirl.define do
  factory :customer do
    name         { Faker::LordOfTheRings.character }
    birthdate    { Faker::Date.birthday(18, 65) }

    state
  end
end
