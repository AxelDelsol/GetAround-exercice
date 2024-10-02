# frozen_string_literal: true

module Common
  #
  # Class responsible for creating a rental price based on a rental.
  #
  class PricingService
    attr_reader :pricer, :commission_handler

    def initialize(pricer:, commission_handler:)
      @pricer = pricer
      @commission_handler = commission_handler
    end

    def call(rental)
      price = pricer.call(rental)
      commission = commission_handler.call(rental, price)
      Common::RentalPrice.new(rental:, price:, commission:)
    end
  end
end
