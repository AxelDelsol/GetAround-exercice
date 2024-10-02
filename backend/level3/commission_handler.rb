# frozen_string_literal: true

require_relative '../common'

#
# Computes and distributes the commission of a rental price.
#
class CommissionHandler
  attr_reader :commission_percent, :insurance_percent, :daily_assistance_fee

  class Error < RuntimeError; end

  def initialize(commission_percent:, insurance_percent:, daily_assistance_fee:)
    @commission_percent = commission_percent
    @insurance_percent = insurance_percent
    @daily_assistance_fee = daily_assistance_fee
  end

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
end
