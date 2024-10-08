# frozen_string_literal: true

RSpec.describe Common::Commission do
  subject(:commission) { described_class.new(**attributes) }

  let(:attributes) { { insurance_fee:, assistance_fee:, drivy_fee: } }
  let(:insurance_fee) { 10 }
  let(:assistance_fee) { 20 }
  let(:drivy_fee) { 30 }

  describe '#initialize' do
    context 'with valid attributes' do
      it 'creates a new commission' do
        expect { commission }.not_to raise_error
      end
    end

    %i[insurance_fee assistance_fee drivy_fee].each do |fee|
      context "with a negative #{fee}" do
        let(fee) { -1 }

        it 'raises a validation error' do
          expect { commission }.to raise_error Common::Validation::Error
        end
      end
    end
  end
end
