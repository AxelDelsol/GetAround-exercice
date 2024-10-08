# frozen_string_literal: true

module Common
  module Extractors
    class ActionsExtractor
      #
      # Extracts the money exchange associated with the rental price.
      #
      # @param [Common::RentalPrice] rental
      # @param [Hash] parent_hash Hash already containing extracted information
      #
      # @return [Hash] parent_hash with the actions
      #
      def call(rental_price, parent_hash)
        parent_hash.tap { |h| h.merge!(actions: build_actions(rental_price)) }
      end

      private

      def build_actions(rental_price)
        [].tap do |actions|
          actions << debit('driver', rental_price.driver_price)
          actions << credit('owner', rental_price.owner_gain)
          actions << credit('insurance', rental_price.insurance_fee)
          actions << credit('assistance', rental_price.assistance_fee)
          actions << credit('drivy', rental_price.drivy_fee)
        end
      end

      def debit(who, amount) = action(who, 'debit', amount)
      def credit(who, amount) = action(who, 'credit', amount)

      def action(who, type, amount) = { who:, type:, amount: }
    end
  end
end
