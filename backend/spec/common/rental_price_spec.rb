# frozen_string_literal: true

RSpec.describe Common::RentalPrice do
  subject(:rental_price) { described_class.new(**attributes) }

  let(:attributes) { { rental:, car_price:, commission:, option_prices: } }
  let(:rental) { build(:rental) }
  let(:car_price) { 1000 }
  let(:commission) do
    build(:commission, insurance_fee: 0, assistance_fee: 0, drivy_fee: 0)
  end
  let(:option_prices) { [] }

  describe '#initialize' do
    context 'with valid attributes' do
      it 'creates a new rental price' do
        expect { rental_price }.not_to raise_error
      end
    end

    context 'with a negative car price' do
      let(:car_price) { -1 }

      it 'raises a validation error' do
        expect { rental_price }.to raise_error Common::Validation::Error
      end
    end
  end

  describe '#id' do
    subject(:id) { rental_price.id }

    it 'returns the rental id' do
      expect(id).to eq rental.id
    end
  end

  describe '#insurance_fee' do
    subject(:insurance_fee) { rental_price.insurance_fee }

    it 'returns the commission insurance fee' do
      expect(insurance_fee).to eq commission.insurance_fee
    end
  end

  describe '#assistance_fee' do
    subject(:assistance_fee) { rental_price.assistance_fee }

    it 'returns the commission assistance fee' do
      expect(assistance_fee).to eq commission.assistance_fee
    end
  end

  describe '#drivy_fee' do
    subject(:drivy_fee) { rental_price.drivy_fee }

    let(:commission) do
      build(:commission, insurance_fee: 0, assistance_fee: 0, drivy_fee: 30)
    end
    let(:option_prices) do
      [build(:option_price,
             option: build(:daily_option, receiver: Common::GET_AROUND),
             price: 50),
       build(:option_price,
             option: build(:daily_option, receiver: Common::OWNER),
             price: 50)]
    end

    it 'combines the commission and options given to GetAround' do
      # 30 (commission) + 50 (option)
      expect(drivy_fee).to eq 80
    end
  end

  describe '#owner_gain' do
    subject(:owner_gain) { rental_price.owner_gain }

    let(:car_price) { 1000 }
    let(:commission) do
      build(:commission, insurance_fee: 10, assistance_fee: 20, drivy_fee: 30)
    end
    let(:option_prices) do
      [build(:option_price,
             option: build(:daily_option, receiver: Common::GET_AROUND),
             price: 50),
       build(:option_price,
             option: build(:daily_option, receiver: Common::OWNER),
             price: 60)]
    end

    it 'corresponds to the car price, options given to the owner minus commissions' do
      # 1000 + 60 (option) - 10 (insurance) - 20 (assistance) - 30 (drivy fee)
      expect(owner_gain).to eq 1000
    end
  end

  describe '#driver_price' do
    subject(:driver_price) { rental_price.driver_price }

    let(:car_price) { 1000 }
    let(:option_prices) do
      [build(:option_price,
             option: build(:daily_option, receiver: Common::GET_AROUND),
             price: 50),
       build(:option_price,
             option: build(:daily_option, receiver: Common::OWNER),
             price: 60)]
    end

    it 'corresponds to the car price and the options' do
      # 1000 + 50 (option owner) 60 (option)
      expect(driver_price).to eq 1110
    end
  end
end
