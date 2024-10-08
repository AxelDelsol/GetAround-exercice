# frozen_string_literal: true

require 'date'
require 'forwardable'
require 'json'

#
# This module contains classes and functions used on multiple levels.
#
module Common
  OWNER = :owner
  GET_AROUND = :get_around
  RECEIVERS = [OWNER, GET_AROUND].freeze

  class Error < StandardError; end

  def self.parse_rentals(content, available_options = {})
    RentalsParser.new(available_options).call(content)
  end

  def self.write_json(filename, rentals_output)
    File.open(filename, 'w') do |f|
      f.puts JSON.pretty_generate({ rentals: rentals_output })
    end
  end
end

require_relative 'common/validation'

require_relative 'common/car'
require_relative 'common/rental'
require_relative 'common/daily_option'
require_relative 'common/option_price'
require_relative 'common/rental_price'
require_relative 'common/commission'

require_relative 'common/rentals_parser'
require_relative 'common/pricers'
require_relative 'common/extractors'
require_relative 'common/commission_handler'
require_relative 'common/pricing_service'
