# frozen_string_literal: true

RSpec.describe Common::Pricer do
  subject(:pricer) { described_class.new(duration_discount) }

  let(:duration_discount) do
    [
      described_class::DurationDiscount.new(start_after: 1, discount_percent: 10),
      described_class::DurationDiscount.new(start_after: 4, discount_percent: 30),
      described_class::DurationDiscount.new(start_after: 10, discount_percent: 50)
    ]
  end

  describe '#call' do
    subject(:call) { pricer.call(rental) }

    let(:car) { Common::Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }

    context 'when the rental duration is smaller than the first discount day' do
      let(:rental) do
        Common::Rental.new(id: 1,
                           car:, start_date: Date.parse('2015-12-8'),
                           end_date: Date.parse('2015-12-8'),
                           distance: 100)
      end

      it 'does not apply the discount' do
        expect(call).to eq 3000
      end
    end

    context 'when the rental duration is inside the discount range' do
      let(:rental) do
        Common::Rental.new(id: 1,
                           car:, start_date: Date.parse('2015-03-31'),
                           end_date: Date.parse('2015-04-01'),
                           distance: 300)
      end

      it 'partially applies the discount' do
        expect(call).to eq 6800
      end
    end

    context 'when the rental duration covers the whole discount range' do
      let(:rental) do
        Common::Rental.new(id: 1,
                           car:, start_date: Date.parse('2015-07-3'),
                           end_date: Date.parse('2015-07-14'),
                           distance: 1000)
      end

      it 'fully applies the discount' do
        expect(call).to eq 27_800
      end
    end

    context 'when there is no discount' do
      let(:duration_discount) { [] }
      let(:rental) do
        Common::Rental.new(id: 1,
                           car:, start_date: Date.parse('2015-12-8'),
                           end_date: Date.parse('2015-12-8'),
                           distance: 100)
      end

      it 'is linear in the distance and duration' do
        expect(call).to eq 3000
      end
    end
  end
end
