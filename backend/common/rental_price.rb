# frozen_string_literal: true

require 'forwardable'

module Common
  #
  # Pricing information related to a car rental.
  #
  class RentalPrice
    extend Forwardable

    attr_reader :rental, :price, :commission

    def initialize(rental:, price:, commission: nil)
      @rental = rental
      @price = price
      @commission = commission
    end

    def_delegators :@rental, :id
    def_delegators :@commission, :insurance_fee, :assistance_fee, :drivy_fee
  end
end
