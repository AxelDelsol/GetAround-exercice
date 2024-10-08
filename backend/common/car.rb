# frozen_string_literal: true

module Common
  class Car
    extend Validation
    attr_reader :id, :price_per_day, :price_per_km

    #
    # Car contructor.
    #
    # @param [Integer] id Identifier
    # @param [Integer] price_per_day Should be >= 0
    # @param [Integer] price_per_km Should be >= 0
    #
    # @raise [Common::Validation::Error] When any input is invalid
    #
    def initialize(id:, price_per_day:, price_per_km:)
      @id = id
      @price_per_day = price_per_day
      @price_per_km = price_per_km

      validate!
    end

    private

    def validate!
      Validation.non_neg_integer!(price_per_day,
                                  "price_per_day is negative <#{price_per_day}>")
      Validation.non_neg_integer!(price_per_km,
                                  "price_per_km is negative <#{price_per_km}>")
    end
  end
end
