# frozen_string_literal: true

FactoryBot.define do
  factory :car, class: 'Common::Car' do
    id { 1 }
    price_per_day { 1000 }
    price_per_km { 100 }

    initialize_with { new(**attributes) }
  end
end
