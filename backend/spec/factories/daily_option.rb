# frozen_string_literal: true

FactoryBot.define do
  factory :daily_option, class: 'Common::DailyOption' do
    name { 'gps' }
    daily_price { 100 }
    receiver { Common::OWNER }

    initialize_with { new(**attributes) }
  end
end
