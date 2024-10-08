# frozen_string_literal: true

module Common
  class DailyOption
    attr_reader :name, :daily_price, :receiver

    #
    # DailyOption constructor.
    #
    # @param [String] name option name. Should not be empty
    # @param [Integer] daily_price Daily price in cents
    # @param [Symbol] receiver Who should receive the payment
    #
    # @raise [Common::Validation::Error] When any input is invalid
    #
    def initialize(name:, daily_price:, receiver:)
      @name = name
      @daily_price = daily_price
      @receiver = receiver

      validate!
    end

    #
    # Cost of using this option for days days.
    #
    # @param [Integer] days Number of days
    #
    # @return [Integer] Cost in cents
    #
    def cost(days) = days * daily_price

    private

    def validate!
      validate_name!
      Validation.non_neg_integer!(daily_price,
                                  "daily_price is negative <#{daily_price}>")
      validate_receiver!
    end

    def validate_name!
      return unless name.empty?

      raise Validation::Error, 'name can not be empty'
    end

    def validate_receiver!
      return if Common::RECEIVERS.include?(receiver)

      raise Validation::Error, "unknown receiver <#{receiver}>"
    end
  end
end
