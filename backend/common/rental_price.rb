# frozen_string_literal: true

module Common
  #
  # Pricing information related to a car rental.
  #
  class RentalPrice
    extend Forwardable

    attr_reader :rental, :car_price, :commission, :option_prices

    #
    # RentalPrice constructor.
    #
    # @param [Common::Rental] rental
    # @param [Integer] car_price Car price in cents
    # @param [Common::Commission] commission
    # @param [Array<Common::OptionPrice>] option_prices
    #
    # @raise [Common::Validation::Error] When any input is invalid
    #
    def initialize(rental:, car_price:, commission:, option_prices:)
      @rental = rental
      @car_price = car_price
      @commission = commission
      @option_prices = option_prices

      validate!
    end

    def_delegators :@rental, :id
    def_delegators :@commission, :insurance_fee, :assistance_fee

    def drivy_fee
      @drivy_fee ||= commission.drivy_fee + option_price_for(GET_AROUND)
    end

    def owner_gain
      @owner_gain ||= car_price + option_price_for(OWNER) -
                      insurance_fee - assistance_fee - commission.drivy_fee
    end

    def driver_price
      @driver_price ||= option_prices.sum(car_price, &:price)
    end

    private

    def validate!
      Validation.non_neg_integer!(car_price,
                                  "car_price <#{car_price}> is negative")
    end

    def split_option_prices
      @split_option_prices ||= option_prices.group_by(&:receiver)
    end

    def option_price_for(receiver)
      split_option_prices.fetch(receiver, []).reduce(0) do |acc, option_price|
        acc + option_price.price
      end
    end
  end
end
