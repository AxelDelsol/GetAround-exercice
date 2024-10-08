# frozen_string_literal: true

RSpec.describe Common::Extractors::OptionsExtractor do
  subject(:options_extractor) { described_class.new }

  describe '#call' do
    subject(:call) { options_extractor.call(rental_price, {}) }

    let(:rental_price) { build(:rental_price, option_prices:) }
    let(:option_prices) do
      [
        build(:option_price, option: build(:daily_option, name: 'gps')),
        build(:option_price, option: build(:daily_option, name: 'baby_seat'))
      ]
    end

    it 'adds the options with their name' do
      expect(call).to eq({ options: %w[gps baby_seat] })
    end

    context 'when there is no options' do
      let(:rental_price) { build(:rental_price, option_prices: []) }

      it 'produces an empty array' do
        expect(call).to eq({ options: [] })
      end
    end
  end
end
