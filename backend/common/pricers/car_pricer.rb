# frozen_string_literal: true

module Common
  module Pricers
    class CarPricer
      #
      # CarPricer constructor.
      #
      # @param [Array<DurationDiscount>] duration_discount Each discount must start at a different day
      #
      def initialize(duration_discount)
        @duration_discount = duration_discount.sort_by(&:start_after).reverse!
      end

      #
      # Computes the rental price of the given rental.
      # The price is guaranteed to be exact if any of in the following sufficient conditions are met:
      # * rental.car.price_per_day is a multiple of 100
      # * rental.car.price_per_day is a multiple of 50 and all discount_percent are even
      # Otherwise, the price is truncated.
      #
      # @param [Common::Rental] rental
      #
      # @return [int] Rental price.
      #
      def call(rental) = (distance_price(rental) + duration_price(rental)).to_i

      DurationDiscount = Data.define(:start_after, :discount_percent) do
        def initialize(...)
          super(...)
          validate!
        end

        private

        def validate!
          Validation.non_neg_integer!(
            start_after,
            "start_after is negative <#{start_after}>"
          )
          Validation.percentage(
            discount_percent,
            "discount_percent is not a valid percentage <#{discount_percent}>"
          )
        end
      end

      private

      attr_reader :duration_discount

      def distance_price(rental) = rental.car.price_per_km * rental.distance

      def duration_price(rental)
        base_price = rental.car.price_per_day
        days_left = rental.rental_duration

        discount_total = duration_discount.reduce(0) do |total, discount|
          next total if days_left <= discount.start_after

          discount_duration = days_left - discount.start_after
          days_left = discount.start_after
          total + discount_duration * base_price * (100 - discount.discount_percent)
        end
        # days_left is either rental_duration or the smallest discount start after
        (discount_total / 100) + days_left * base_price
      end
    end
  end
end
