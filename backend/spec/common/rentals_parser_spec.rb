# frozen_string_literal: true

RSpec.describe Common::RentalsParser do
  subject(:parser) { described_class.new(available_options) }

  let(:available_options) { {} }

  describe '#call' do
    subject(:call) { parser.call(content) }

    context 'with minimum content' do
      let(:content) do
        File.read(File.join(RSPEC_ROOT, 'etc', 'minimum_input.json'))
      end

      it 'correctly parses it' do
        expect(call.first).to be_an_instance_of(Common::Rental)
      end
    end

    context 'with complex content' do
      let(:available_options) do
        {
          'gps' => build(:daily_option, name: 'gps',
                                        daily_price: 500,
                                        receiver: Common::OWNER)
        }
      end
      let(:content) do
        File.read(File.join(RSPEC_ROOT, 'etc', 'maximum_input.json'))
      end

      it 'correctly parses it' do
        expect(call.first).to be_an_instance_of(Common::Rental)
      end
    end

    context 'when a car attribute is missing' do
      let(:content) do
        File.read(File.join(RSPEC_ROOT,
                            'etc', 'car_missing_key.json'))
      end

      it 'raises a parsing error' do
        expect { call }.to raise_error described_class::Error
      end
    end

    context 'when a car value is invalid' do
      let(:content) do
        File.read(File.join(RSPEC_ROOT,
                            'etc', 'car_invalid_value.json'))
      end

      it 'raises a validation error' do
        expect { call }.to raise_error Common::Validation::Error
      end
    end

    context 'when a rental attribute is missing' do
      let(:content) do
        File.read(File.join(RSPEC_ROOT,
                            'etc', 'rental_missing_key.json'))
      end

      it 'raises a parsing error' do
        expect { call }.to raise_error described_class::Error
      end
    end

    context 'when a rental references an unknown car' do
      let(:content) do
        File.read(File.join(RSPEC_ROOT,
                            'etc', 'unknown_car.json'))
      end

      it 'raises a parsing error' do
        expect { call }.to raise_error described_class::Error
      end
    end

    context 'when a rental value is invalid' do
      let(:content) do
        File.read(File.join(RSPEC_ROOT,
                            'etc', 'rental_invalid_value.json'))
      end

      it 'raises a validation error' do
        expect { call }.to raise_error Common::Validation::Error
      end
    end

    context 'when an option is not available' do
      let(:content) do
        File.read(File.join(RSPEC_ROOT,
                            'etc', 'unknown_option.json'))
      end

      it 'raises a parsing error' do
        expect { call }.to raise_error described_class::Error
      end
    end
  end
end
