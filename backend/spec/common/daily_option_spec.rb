# frozen_string_literal: true

RSpec.describe Common::DailyOption do
  subject(:daily_option) { described_class.new(**attributes) }

  let(:attributes) { { name:, daily_price:, receiver: } }
  let(:name) { 'gps' }
  let(:daily_price) { 10 }
  let(:receiver) { Common::OWNER }

  describe '#initialize' do
    context 'with valid attributes' do
      it 'creates a new daily option' do
        expect { daily_option }.not_to raise_error
      end
    end

    Common::RECEIVERS.each do |rcv|
      context "with receiver=#{rcv}" do
        let(:receiver) { rcv }

        it 'creates a new daily option' do
          expect { daily_option }.not_to raise_error
        end
      end
    end

    context 'with an empty name' do
      let(:name) { '' }

      it 'raises a validation error' do
        expect { daily_option }.to raise_error Common::Validation::Error
      end
    end

    context 'with an unknown receiver' do
      let(:receiver) { :unknown }

      it 'raises a validation error' do
        expect { daily_option }.to raise_error Common::Validation::Error
      end
    end
  end

  describe '#cost' do
    subject(:cost) { daily_option.cost(3) }

    it 'returns the cost for the given number of days' do
      expect(cost).to eq 30
    end
  end
end
