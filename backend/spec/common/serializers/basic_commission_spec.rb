# frozen_string_literal: true

RSpec.describe Common::Serializers::BasicCommission do
  subject(:serializer) { described_class.new(parent_serializer) }

  let(:parent_serializer) do
    proc { |_| { id: 1, price: 42 } }
  end

  describe '#call' do
    subject(:call) { serializer.call(rental_price) }

    let(:rental_price) do
      Common::RentalPrice.new(
        rental: instance_double(Common::Rental),
        price: 42,
        commission: Common::Commission.new(
          insurance_fee: 1, assistance_fee: 2, drivy_fee: 3
        )
      )
    end

    it 'returns a hash with the id and price' do
      expect(call).to eq({ id: 1, price: 42, commission: {
                           insurance_fee: 1, assistance_fee: 2, drivy_fee: 3
                         } })
    end
  end
end
