# frozen_string_literal: true

module Common
  module Serializers
    #
    # Generates a hash containing rental_price data for serialization.
    # Included: id, price
    # Can be seen as a way to convert a rental price as a DTO before serialization
    # in JSON or other format
    #
    class Basic
      def call(rental_price) = { id: rental_price.id, price: rental_price.price }
    end
  end
end
