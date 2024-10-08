# frozen_string_literal: true

require 'date'
require 'json'

require_relative '../common'

INPUT_FILENAME = File.join(__dir__, 'data', 'input.json')
OUTPUT_FILENAME = File.join(__dir__, 'data', 'output.json')

rentals = Common.parse_rentals(File.read(INPUT_FILENAME))

car_pricer = Common::Pricers::CarPricer.new([])
service = Common::PricingService.new(car_pricer:)

prices = rentals.map { service.call(_1) }

Extractors = Common::Extractors
extractor = Extractors::CompositionExtractor.new(
  [Extractors::IdExtractor.new, Extractors::PriceExtractor.new]
)

rentals_output = prices.sort_by(&:id).map { extractor.call(_1, {}) }

Common.write_json(OUTPUT_FILENAME, rentals_output)
