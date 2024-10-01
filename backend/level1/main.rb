# frozen_string_literal: true

require 'date'
require 'json'

require_relative '../common'

INPUT_FILENAME = File.join(__dir__, 'data', 'input.json')
OUTPUT_FILENAME = File.join(__dir__, 'data', 'output.json')

rentals = Common.parse_rentals(File.read(INPUT_FILENAME))

# This level is the level2 without any discounts
pricer = Common::Pricer.new([])
prices = rentals.map { pricer.call(_1) }

Common.dump_prices(OUTPUT_FILENAME, prices)
