# frozen_string_literal: true

RSpec.describe Common::Serializers::Basic do
  subject(:serializer) { described_class.new }

  describe '#call' do
    subject(:call) { serializer.call(rental_price) }

    let(:rental_price) do
      Common::RentalPrice.new(
        rental: instance_double(Common::Rental, id: 1),
        price: 42,
        commission: instance_double(Common::Commission)
      )
    end

    it 'returns a hash with the id and price' do
      expect(call).to eq({ id: 1, price: 42 })
    end
  end
end
