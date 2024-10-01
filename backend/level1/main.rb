# frozen_string_literal: true

require 'date'
require 'json'

INPUT_FILENAME = File.join(__dir__, 'data', 'input.json')
OUTPUT_FILENAME = File.join(__dir__, 'data', 'output.json')

# This methods only exists to have the main program first to make it easier to read.
def main
  rentals = parse_input(File.read(INPUT_FILENAME))

  prices = rentals.map { compute_rental_price(_1) }

  File.open(OUTPUT_FILENAME, 'w') do |f|
    # While using map(&:to_h) is simpler, it creates a sneaky coupling
    # between the model and its serialization.
    formatted_prices = prices.map do |rental_price|
      { id: rental_price.id, price: rental_price.price }
    end

    f.puts JSON.pretty_generate({ rentals: formatted_prices })
  end
end

Car = Data.define(:id, :price_per_day, :price_per_km)

Rental = Data.define(:id, :car, :start_date, :end_date, :distance) do
  def rental_duration = (end_date - start_date).to_i + 1
end

RentalPrice = Data.define(:id, :price)

# Assumption: data contained in the content string is valid.
# If it is a mistake, validation is needed here.
def parse_input(content)
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

def compute_rental_price(rental)
  car = rental.car
  RentalPrice.new(
    id: rental.id,
    price: car.price_per_day * rental.rental_duration + car.price_per_km * rental.distance
  )
end

main
