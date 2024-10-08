# frozen_string_literal: true

module Common
  #
  # Computes and distributes the commission of a rental price.
  #
  class CommissionHandler
    attr_reader :commission_percent, :insurance_percent, :daily_assistance_fee

    class Error < RuntimeError; end

    #
    # CommissionHandler constructor.
    #
    # @param [Integer] commission_percent Percentage of price taken for the commission
    # @param [Integer] insurance_percent Percentage of the commission for the insurance
    # @param [Integer] daily_assistance_fee Integer in cents for the road assistance.
    #
    # @raise [Common::Validation::Error] When any input is invalid
    #
    def initialize(commission_percent:, insurance_percent:, daily_assistance_fee:)
      @commission_percent = commission_percent
      @insurance_percent = insurance_percent
      @daily_assistance_fee = daily_assistance_fee

      validate!
    end

    #
    # Computes the commission for a rental estimated at price.
    #
    # @param [Common::Rental] rental
    # @param [Integer] price Rental price estimate
    #
    # @return [Common::Commission] Commission for each actors
    #
    def call(rental, price)
      commission_price = (price * commission_percent) / 100

      insurance_fee = (commission_price * insurance_percent) / 100
      assistance_fee = rental.rental_duration * daily_assistance_fee

      if insurance_fee + assistance_fee > commission_price
        raise Error,
              "Can not distribute commission for rental <#{rental.id}>"
      end

      drivy_fee = commission_price - insurance_fee - assistance_fee

      Common::Commission.new(insurance_fee:, assistance_fee:, drivy_fee:)
    end

    private

    def validate!
      Validation.percentage(
        commission_percent,
        "commission_percent is not a valid percentage <#{commission_percent}>"
      )
      Validation.percentage(
        insurance_percent,
        "insurance_percent is not a valid percentage <#{insurance_percent}>"
      )
      Validation.non_neg_integer!(
        daily_assistance_fee,
        "daily_assistance_fee is negative <#{daily_assistance_fee}>"
      )
    end
  end
end
