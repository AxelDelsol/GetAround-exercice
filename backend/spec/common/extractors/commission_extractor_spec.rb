# frozen_string_literal: true

RSpec.describe Common::Extractors::CommissionExtractor do
  subject(:commission_extractor) { described_class.new }

  describe '#call' do
    subject(:call) { commission_extractor.call(rental_price, {}) }

    let(:rental_price) do
      build(:rental_price,
            commission: build(:commission,
                              insurance_fee: 10,
                              assistance_fee: 20, drivy_fee: 30))
    end

    it 'extracts the commissions' do
      expect(call).to eq({ commission: { insurance_fee: 10,
                                         assistance_fee: 20,
                                         drivy_fee: 30 } })
    end
  end
end
