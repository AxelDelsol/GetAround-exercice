# frozen_string_literal: true

module Common
  module Extractors
    class CommissionExtractor
      #
      # Extracts the commissions even if they are 0.
      #
      # @param [Common::RentalPrice] rental
      # @param [Hash] parent_hash Hash already containing extracted information
      #
      # @return [Hash] parent_hash with the commissions
      #
      def call(rental_price, parent_hash)
        parent_hash.tap do |h|
          commission = {
            insurance_fee: rental_price.insurance_fee,
            assistance_fee: rental_price.assistance_fee,
            drivy_fee: rental_price.drivy_fee
          }
          h.merge!(commission:)
        end
      end
    end
  end
end
