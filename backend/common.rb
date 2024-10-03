# frozen_string_literal: true

require 'date'
require 'json'

#
# This module contains classes and functions used on multiple levels.
#
module Common
  Car = Data.define(:id, :price_per_day, :price_per_km)

  Rental = Data.define(:id, :car, :start_date, :end_date, :distance) do
    def rental_duration = (end_date - start_date).to_i + 1
  end

  def self.parse_rentals(content)
    data = JSON.parse(content, symbolize_names: true)
    cars = data[:cars].map { |car| [car[:id], Car.new(**car)] }.to_h
    data[:rentals].map do |rental|
      Rental.new(id: rental[:id],
                 car: cars.fetch(rental[:car_id]),
                 start_date: Date.parse(rental[:start_date]),
                 end_date: Date.parse(rental[:end_date]),
                 distance: rental[:distance])
    end
  end

  def self.dump_prices(filename, prices, serializer:)
    File.open(filename, 'w') do |f|
      formatted_prices = prices.sort_by(&:id).map { serializer.call(_1) }
      f.puts JSON.pretty_generate({ rentals: formatted_prices })
    end
  end
end

require_relative 'common/rental_price'
require_relative 'common/commission'
require_relative 'common/pricer'
require_relative 'common/commission_handler'
require_relative 'common/pricing_service'

require_relative 'common/serializers'
