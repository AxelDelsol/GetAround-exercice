# frozen_string_literal: true

FactoryBot.define do
  factory :commission, class: 'Common::Commission' do
    insurance_fee { 0 }
    assistance_fee { 0 }
    drivy_fee { 0 }

    initialize_with { new(**attributes) }
  end
end
