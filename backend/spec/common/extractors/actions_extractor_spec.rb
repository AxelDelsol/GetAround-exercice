# frozen_string_literal: true

RSpec.describe Common::Extractors::ActionsExtractor do
  subject(:actions_extractor) { described_class.new }

  describe '#call' do
    subject(:call) { actions_extractor.call(rental_price, {}) }

    let(:rental_price) do
      build(:rental_price,
            car_price: 3000,
            commission: Common::Commission.new(
              insurance_fee: 450,
              assistance_fee: 100,
              drivy_fee: 350
            ))
    end

    let(:expected_hash) do
      {
        actions: [
          {
            who: 'driver',
            type: 'debit',
            amount: 3000
          },
          {
            who: 'owner',
            type: 'credit',
            amount: 2100
          },
          {
            who: 'insurance',
            type: 'credit',
            amount: 450
          },
          {
            who: 'assistance',
            type: 'credit',
            amount: 100
          },
          {
            who: 'drivy',
            type: 'credit',
            amount: 350
          }
        ]
      }
    end

    it 'details each money exchange' do
      expect(call).to eq expected_hash
    end
  end
end
