# frozen_string_literal: true

module Common
  module Extractors
    class OptionsExtractor
      #
      # Extracts the rental price options (name only).
      #
      # @param [Common::RentalPrice] rental
      # @param [Hash] parent_hash Hash already containing extracted information
      #
      # @return [Hash] parent_hash with the options.
      #
      def call(rental_price, parent_hash)
        parent_hash.tap do |h|
          h.merge!(options: rental_price.option_prices.map(&:name))
        end
      end
    end
  end
end
