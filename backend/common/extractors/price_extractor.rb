# frozen_string_literal: true

module Common
  module Extractors
    class PriceExtractor
      #
      # Extracts the rental price driver_price as price.
      #
      # @param [Common::RentalPrice] rental
      # @param [Hash] parent_hash Hash already containing extracted information
      #
      # @return [Hash] parent_hash with the price
      #
      def call(rental_price, parent_hash)
        parent_hash.tap { |h| h.merge!(price: rental_price.driver_price) }
      end
    end
  end
end
