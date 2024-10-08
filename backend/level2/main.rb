# frozen_string_literal: true

require 'date'
require 'json'

require_relative '../common'

INPUT_FILENAME = File.join(__dir__, 'data', 'input.json')
OUTPUT_FILENAME = File.join(__dir__, 'data', 'output.json')

DurationDiscount = Common::Pricers::CarPricer::DurationDiscount
DISCOUNT = [
  DurationDiscount.new(start_after: 1, discount_percent: 10),
  DurationDiscount.new(start_after: 4, discount_percent: 30),
  DurationDiscount.new(start_after: 10, discount_percent: 50)
].freeze

rentals = Common.parse_rentals(File.read(INPUT_FILENAME))

car_pricer = Common::Pricers::CarPricer.new(DISCOUNT)
service = Common::PricingService.new(car_pricer:)

prices = rentals.map { service.call(_1) }

Extractors = Common::Extractors
extractor = Extractors::CompositionExtractor.new(
  [Extractors::IdExtractor.new, Extractors::PriceExtractor.new]
)

rentals_output = prices.sort_by(&:id).map { extractor.call(_1, {}) }

Common.write_json(OUTPUT_FILENAME, rentals_output)
