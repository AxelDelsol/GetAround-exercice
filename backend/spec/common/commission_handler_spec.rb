# frozen_string_literal: true

RSpec.describe Common::CommissionHandler do
  subject(:handler) do
    described_class.new(commission_percent: 30,
                        insurance_percent: 50,
                        daily_assistance_fee: 100)
  end

  describe '#call' do
    subject(:call) { handler.call(rental, price) }

    let(:rental) do
      Common::Rental.new(
        id: 1,
        car: instance_double(Common::Car),
        start_date: Date.parse('2015-12-8'),
        end_date: Date.parse('2015-12-8'),
        distance: 100
      )
    end
    let(:price) { 3000 }

    it 'computes the commission', :aggregate_failures do
      expect(call).to eq Common::Commission.new(
        insurance_fee: 450, assistance_fee: 100, drivy_fee: 350
      )
    end

    context 'when the commission can not be computed' do
      let(:price) { 10 }

      it 'raises an error' do
        expect { call }.to raise_error described_class::Error,
                                       "Can not distribute commission for rental <#{rental.id}>"
      end
    end
  end
end
