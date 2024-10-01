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

  RentalPrice = Data.define(:id, :price)

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

  def self.dump_prices(filename, prices)
    File.open(filename, 'w') do |f|
      # While using map(&:to_h) is simpler, it creates a sneaky coupling
      # between the model and its serialization.
      formatted_prices = prices.sort_by(&:id).map do |rental_price|
        { id: rental_price.id, price: rental_price.price }
      end

      f.puts JSON.pretty_generate({ rentals: formatted_prices })
    end
  end
end

require_relative 'common/pricer'
