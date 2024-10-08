# frozen_string_literal: true

module Common
  class OptionPrice
    extend Forwardable

    attr_reader :option, :price

    #
    # OptionPrice constructor.
    #
    # @param [Common::DailyOption] option
    # @param [Integer] price Price in cents
    #
    # @raise [Common::Validation::Error] When any input is invalid
    #
    def initialize(option:, price:)
      @option = option
      @price = price

      validate!
    end

    def_delegators :@option, :name, :receiver

    private

    def validate!
      Validation.non_neg_integer!(price, "price is negative <#{price}>")
    end
  end
end
