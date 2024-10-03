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

COMMISSION_CONFIG = {
  commission_percent: 30,
  insurance_percent: 50,
  daily_assistance_fee: 100
}.freeze

rentals = Common.parse_rentals(File.read(INPUT_FILENAME))

pricer = Common::Pricer.new(DISCOUNT)
commission_handler = Common::CommissionHandler.new(**COMMISSION_CONFIG)
service = Common::PricingService.new(pricer:, commission_handler:)

prices = rentals.map { service.call(_1) }

Common.dump_prices(OUTPUT_FILENAME, prices,
                   serializer: Common::Serializers::BasicCommission.new)
