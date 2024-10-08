# frozen_string_literal: true

RSpec.describe Common::Extractors::CompositionExtractor do
  subject(:composition_extractor) { described_class.new(extractors) }

  let(:extractors) do
    [
      proc { |_, parent_hash| parent_hash.tap { |h| h[:a] = 1 } },
      proc { |_, parent_hash| parent_hash.tap { |h| h[:b] = 2 } }
    ]
  end

  describe '#call' do
    subject(:call) { composition_extractor.call(build(:rental_price), {}) }

    it 'applies each extractors in order' do
      expect(call).to eq({ a: 1, b: 2 })
    end
  end
end
