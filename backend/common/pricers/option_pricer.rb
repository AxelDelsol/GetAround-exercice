# frozen_string_literal: true

module Common
  module Pricers
    class OptionPricer
      #
      # Computes the costs of each options for the given rental.
      #
      # @param [Common::Rental] rental
      #
      # @return [Array<Common::OptionPrice] Prices for each options or empty array.
      #
      def call(rental)
        rental.options.map do |option|
          OptionPrice.new(option:, price: option.cost(rental.rental_duration))
        end
      end
    end
  end
end
