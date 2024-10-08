# frozen_string_literal: true

FactoryBot.define do
  factory :option_price, class: 'Common::OptionPrice' do
    option { association :daily_option }
    price { 100 }
    initialize_with { new(**attributes) }
  end
end
