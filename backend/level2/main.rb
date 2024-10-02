# frozen_string_literal: true

require 'date'
require 'json'

require_relative '../common'

INPUT_FILENAME = File.join(__dir__, 'data', 'input.json')
OUTPUT_FILENAME = File.join(__dir__, 'data', 'output.json')

DISCOUNT = [
  Common::Pricer::DurationDiscount.new(start_after: 1, discount_percent: 10),
  Common::Pricer::DurationDiscount.new(start_after: 4, discount_percent: 30),
  Common::Pricer::DurationDiscount.new(start_after: 10, discount_percent: 50)
].freeze

rentals = Common.parse_rentals(File.read(INPUT_FILENAME))

pricer = Common::Pricer.new(DISCOUNT)
commission_handler = proc do |_rental, _price|
  Common::Commission.new(insurance_fee: 0, assistance_fee: 0, drivy_fee: 0)
end
service = Common::PricingService.new(pricer:, commission_handler:)

prices = rentals.map { service.call(_1) }

Common.dump_prices(OUTPUT_FILENAME, prices,
                   serializer: Common::Serializers::Basic.new)
