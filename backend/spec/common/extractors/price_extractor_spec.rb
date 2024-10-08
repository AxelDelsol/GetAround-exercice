# frozen_string_literal: true

RSpec.describe Common::Extractors::PriceExtractor do
  subject(:price_extractor) { described_class.new }

  describe '#call' do
    subject(:call) { price_extractor.call(rental_price, {}) }

    let(:rental_price) { build(:rental_price) }

    it 'extracts the rental id' do
      expect(call).to eq({ price: rental_price.driver_price })
    end
  end
end
