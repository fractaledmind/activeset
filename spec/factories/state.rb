# frozen_string_literal: true

FactoryGirl.define do
  factory :state do
    name         { Faker::Address.state }
    latitude     { Faker::Address.latitude.to_f }
  end
end
