# frozen_string_literal: true

module Common
  module Serializers
    #
    # Generates a hash containing rental_price data for serialization.
    # Included: id, price and every money transactions.
    # Can be seen as a way to convert a rental price as a DTO before serialization
    # in JSON or other format
    #
    class Action
      def call(rental_price)
        { id: rental_price.id, actions: build_actions(rental_price) }
      end

      private

      def build_actions(rental_price)
        [].tap do |actions|
          actions << debit('driver', rental_price.price)
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
