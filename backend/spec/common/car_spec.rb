# frozen_string_literal: true

RSpec.describe Common::Car do
  subject(:car) { described_class.new(**attributes) }

  let(:attributes) { { id: 1, price_per_day:, price_per_km: } }
  let(:price_per_day) { 10 }
  let(:price_per_km) { 5 }

  describe '#initialize' do
    context 'with valid attributes' do
      it 'creates a new car' do
        expect { car }.not_to raise_error
      end
    end

    context 'with a negative price_per_day' do
      let(:price_per_day) { -1 }

      it 'raises a validation error' do
        expect { car }.to raise_error Common::Validation::Error
      end
    end

    context 'with a negative price_per_km' do
      let(:price_per_km) { -1 }

      it 'raises a validation error' do
        expect { car }.to raise_error Common::Validation::Error
      end
    end
  end
end
