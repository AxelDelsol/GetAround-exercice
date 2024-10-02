# frozen_string_literal: true

module Common
  module Serializers
    #
    # Generates a hash containing rental_price data for serialization.
    # Included: id, price and commission
    # Can be seen as a way to convert a rental price as a DTO before serialization
    # in JSON or other format
    #
    class BasicCommission
      attr_reader :parent_serializer

      def initialize(parent_serializer = Basic.new)
        @parent_serializer = parent_serializer
      end

      def call(rental_price)
        parent_serializer.call(rental_price).tap do |dto|
          commission = {
            insurance_fee: rental_price.insurance_fee,
            assistance_fee: rental_price.assistance_fee,
            drivy_fee: rental_price.drivy_fee
          }
          dto.merge!(commission:)
        end
      end
    end
  end
end
