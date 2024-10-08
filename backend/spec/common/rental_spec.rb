# frozen_string_literal: true

RSpec.describe Common::Rental do
  subject(:rental) { described_class.new(**attributes) }

  let(:attributes) do
    { id: 1, car: build(:car), start_date:, end_date:, distance:, options: [] }
  end
  let(:start_date) { Date.new(2024, 1, 1) }
  let(:end_date) { Date.new(2024, 1, 1) }
  let(:distance) { 1000 }

  describe '#initialize' do
    context 'with valid attributes' do
      it 'creates a new rental' do
        expect { rental }.not_to raise_error
      end
    end

    context 'with a distance' do
      let(:distance) { -1 }

      it 'raises a validation error' do
        expect { rental }.to raise_error Common::Validation::Error
      end
    end

    context 'when start_date > end_date' do
      let(:start_date) { Date.new(2024, 1, 2) }
      let(:end_date) { Date.new(2024, 1, 1) }

      it 'raises a validation error' do
        expect { rental }.to raise_error Common::Validation::Error
      end
    end

    describe '#rental_duration' do
      subject(:rental_duration) { rental.rental_duration }

      it 'returns how many days the car was rented' do
        expect(rental_duration).to eq 1
      end
    end
  end
end
