# frozen_string_literal: true

FactoryBot.define do
  factory :rental, class: 'Common::Rental' do
    id { 1 }
    car { association :car }
    start_date { Date.new(2024, 1, 1) }
    end_date { Date.new(2024, 1, 1) }
    distance { 100 }
    options { [] }

    initialize_with { new(**attributes) }
  end
end
