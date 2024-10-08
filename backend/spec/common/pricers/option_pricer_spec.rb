# frozen_string_literal: true

RSpec.describe Common::Pricers::OptionPricer do
  subject(:option_pricer) { described_class.new }

  describe '#call' do
    subject(:call) { option_pricer.call(rental) }

    let(:rental) { build(:rental, options: [option]) }
    let(:option) { build(:daily_option) }

    it 'applies the cost of each option' do
      expect(call.first.price).to eq option.cost(rental.rental_duration)
    end
  end
end
