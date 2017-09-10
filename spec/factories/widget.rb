# frozen_string_literal: true

FactoryGirl.define do
  factory :widget do
    quantity      { Faker::Number.between(1, 10) }
    color         { Widget::POSSIBLE_COLORS.sample }
    description   { Faker::RickAndMorty.quote }
    ship_by       { Faker::Date.between(1.year.ago, 1.year.from_now) }
    shipped       { ship_by < Date.today ? true : false }

    customer
  end
end
