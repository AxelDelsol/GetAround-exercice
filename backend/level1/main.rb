# frozen_string_literal: true

require 'date'
require 'json'

require_relative '../common'

INPUT_FILENAME = File.join(__dir__, 'data', 'input.json')
OUTPUT_FILENAME = File.join(__dir__, 'data', 'output.json')

rentals = Common.parse_rentals(File.read(INPUT_FILENAME))

# This level is the level2 without any discounts
pricer = Common::Pricer.new([])
commission_handler = proc do |_rental, _price|
  Common::Commission.new(insurance_fee: 0, assistance_fee: 0, drivy_fee: 0)
end
service = Common::PricingService.new(pricer:, commission_handler:)

prices = rentals.map { service.call(_1) }

Common.dump_prices(OUTPUT_FILENAME, prices,
                   serializer: Common::Serializers::Basic.new)
