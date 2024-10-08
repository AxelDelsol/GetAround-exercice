# frozen_string_literal: true

RSpec.describe Common::OptionPrice do
  subject(:option_price) { described_class.new(**attributes) }

  let(:attributes) { { option:, price: } }
  let(:option) { build(:daily_option) }
  let(:price) { 10 }

  describe '#initialize' do
    context 'with valid attributes' do
      it 'creates a new option price' do
        expect { option_price }.not_to raise_error
      end
    end

    context 'with a negative price' do
      let(:price) { -1 }

      it 'raises a validation error' do
        expect { option_price }.to raise_error Common::Validation::Error
      end
    end
  end

  describe '#name' do
    subject(:name) { option_price.name }

    it 'returns the option name' do
      expect(name).to eq option.name
    end
  end

  describe '#receiver' do
    subject(:receiver) { option_price.receiver }

    it 'returns the option receiver' do
      expect(receiver).to eq option.receiver
    end
  end
end
