# frozen_string_literal: true

FactoryBot.define do
  factory :duration_discount, class: 'Common::Pricers::CarPricer::DurationDiscount' do
    start_after { 1 }
    discount_percent { 10 }

    initialize_with { new(**attributes) }
  end
end
