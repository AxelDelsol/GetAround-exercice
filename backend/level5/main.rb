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

COMMISSION_CONFIG = {
  commission_percent: 30,
  insurance_percent: 50,
  daily_assistance_fee: 100
}.freeze

AVAILABLE_OPTIONS_LIST = [
  Common::DailyOption.new(name: 'gps', daily_price: 500, receiver: Common::OWNER),
  Common::DailyOption.new(name: 'baby_seat', daily_price: 200, receiver: Common::OWNER),
  Common::DailyOption.new(name: 'additional_insurance', daily_price: 1000, receiver: Common::GET_AROUND)
].freeze
AVAILABLE_OPTIONS = AVAILABLE_OPTIONS_LIST.map { |opt| [opt.name, opt] }.to_h.freeze

rentals = Common.parse_rentals(File.read(INPUT_FILENAME), AVAILABLE_OPTIONS)

car_pricer = Common::Pricers::CarPricer.new(DISCOUNT)
commission_handler = Common::CommissionHandler.new(**COMMISSION_CONFIG)
option_pricer = Common::Pricers::OptionPricer.new
service = Common::PricingService.new(car_pricer:, commission_handler:, option_pricer:)

prices = rentals.map { service.call(_1) }

Extractors = Common::Extractors
extractor = Extractors::CompositionExtractor.new(
  [Extractors::IdExtractor.new,
   Extractors::OptionsExtractor.new,
   Extractors::ActionsExtractor.new]
)

rentals_output = prices.sort_by(&:id).map { extractor.call(_1, {}) }

Common.write_json(OUTPUT_FILENAME, rentals_output)
