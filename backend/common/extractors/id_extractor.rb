# frozen_string_literal: true

module Common
  module Extractors
    class IdExtractor
      #
      # Extracts the rental price id.
      #
      # @param [Common::RentalPrice] rental
      # @param [Hash] parent_hash Hash already containing extracted information
      #
      # @return [Hash] parent_hash with the rental price id
      #
      def call(rental_price, parent_hash)
        parent_hash.tap { |h| h.merge!(id: rental_price.id) }
      end
    end
  end
end
