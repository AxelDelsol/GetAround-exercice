# frozen_string_literal: true

module Common
  #
  # Class responsible for creating a rental price based on a rental.
  #
  class PricingService
    attr_reader :car_pricer, :commission_handler, :option_pricer

    #
    # Default commission handler returning a zero commission.
    #
    # @return [Common::Commission]
    #
    def self.default_commission_handler
      proc do |_rental, _price|
        Common::Commission.new(insurance_fee: 0, assistance_fee: 0, drivy_fee: 0)
      end
    end

    #
    # Default option pricer returning an empty array.
    #
    #
    # @return [Array<Common::OptionPrice] Empty array
    #
    def self.default_option_pricer = proc { |_rental| [] }

    #
    # PricingService constructor.
    #
    # @param [#call] car_pricer Any callable accepting a rental and returning a price
    # @param [#call] commission_handler Any callable accepting a rental and a price and returning a Common::Commission
    # @param [#call] option_pricer Any callable accepting a rental and returning an array of Common::OptionPrice
    #
    def initialize(car_pricer:, commission_handler: nil, option_pricer: nil)
      @car_pricer = car_pricer
      @commission_handler = commission_handler ||
                            PricingService.default_commission_handler
      @option_pricer = option_pricer ||
                       PricingService.default_option_pricer
    end

    #
    # Computes a rental price for the given rental.
    #
    # @param [Common::Rental] rental
    #
    # @return [Common::RentalPrice]
    #
    def call(rental)
      car_price = car_pricer.call(rental)
      commission = commission_handler.call(rental, car_price)
      option_prices = option_pricer.call(rental)
      Common::RentalPrice.new(rental:, car_price:, commission:, option_prices:)
    end
  end
end
