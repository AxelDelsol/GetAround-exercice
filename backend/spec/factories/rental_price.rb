# frozen_string_literal: true

FactoryBot.define do
  factory :rental_price, class: 'Common::RentalPrice' do
    rental { association :rental }
    car_price { 1000 }
    commission { association :commission }
    option_prices { [] }

    initialize_with { new(**attributes) }
  end
end
