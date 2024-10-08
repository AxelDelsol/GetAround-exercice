# frozen_string_literal: true

module Common
  #
  # Parse a JSON file into an array of Rentals
  #
  class RentalsParser
    attr_reader :available_options

    class Error < Common::Error; end

    #
    # RentalsParser constructor.
    #
    # @param [Hash<String,Common::Option] available_options Hash of available options. The key is the option name
    def initialize(available_options = {})
      @available_options = available_options
    end

    #
    # Parse the content string to create rentals.
    #
    # @param [String] content JSON format of rentals
    #
    # @return [Array<Common::Rental]
    #
    # @raise [JSON::ParserError] When the content is not a valid JSON
    # @raise [Error] When the parsing fails
    # @raise [Common::Validation::Error] When the values contained in the string are invalid
    #
    #
    def call(content)
      data = JSON.parse(content, symbolize_names: true)
      cars = parse_cars(data[:cars])
      options = parse_options(data.fetch(:options, []))
      parse_rentals(data[:rentals], cars, options)
    end

    private

    def fetch_attribute(data, attribute)
      value = data.fetch(attribute, nil)

      return value unless value.nil?

      raise Error, "Attribute <#{attribute}> is missing or null in #{data}"
    end

    def parse_cars(cars)
      cars.map do |car_h|
        car = Car.new(
          id: fetch_attribute(car_h, :id),
          price_per_day: fetch_attribute(car_h, :price_per_day),
          price_per_km: fetch_attribute(car_h, :price_per_km)
        )
        [car_h[:id], car]
      end.to_h
    end

    def parse_options(options)
      options.group_by { |opt| opt[:rental_id] }
             .transform_values do |opts|
               opts.map do |opt|
                 available_options.fetch(opt[:type]) do |opt_name|
                   raise Error, "Unknown option <#{opt_name}>"
                 end
               end
             end
    end

    def parse_rentals(rentals, cars, options)
      rentals.map do |rental|
        Rental.new(id: fetch_attribute(rental, :id),
                   car: fetch_car(cars, fetch_attribute(rental, :car_id)),
                   start_date: Date.parse(fetch_attribute(rental, :start_date)),
                   end_date: Date.parse(fetch_attribute(rental, :end_date)),
                   distance: fetch_attribute(rental, :distance),
                   options: options.fetch(rental[:id], []))
      end
    end

    def fetch_car(cars, car_id)
      cars.fetch(car_id) do |id|
        raise Error, "Could not find the car with id <#{id}>"
      end
    end
  end
end
