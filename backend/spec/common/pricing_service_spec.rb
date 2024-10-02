# frozen_string_literal: true

RSpec.describe Common::PricingService do
  subject(:service) { described_class.new(pricer:, commission_handler:) }

  let(:pricer) { proc { |_rental| 100 } }
  let(:commission_handler) { proc { |_rental, _price| commission } }
  let(:commission) do
    Common::Commission.new(insurance_fee: 1, assistance_fee: 2, drivy_fee: 3)
  end

  describe '#call' do
    subject(:call) { service.call(rental) }

    let(:rental) { instance_double(Common::Rental) }

    it 'returns a Common::RentalPrice' do
      expect(call).to be_an_instance_of(Common::RentalPrice)
    end

    it 'injects the rental' do
      expect(call.rental).to eq rental
    end

    it 'uses the pricer to compute the rental price' do
      expect(call.price).to eq 100
    end

    it 'uses the commission handler to compute the commission' do
      expect(call.commission).to eq commission
    end
  end
end
