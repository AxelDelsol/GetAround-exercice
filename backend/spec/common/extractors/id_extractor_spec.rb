# frozen_string_literal: true

RSpec.describe Common::Extractors::IdExtractor do
  subject(:id_extractor) { described_class.new }

  describe '#call' do
    subject(:call) { id_extractor.call(rental_price, {}) }

    let(:rental_price) { build(:rental_price, rental: build(:rental, id: 42)) }

    it 'extracts the rental id' do
      expect(call).to eq({ id: 42 })
    end
  end
end
