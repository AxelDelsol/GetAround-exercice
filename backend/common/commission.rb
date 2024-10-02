# frozen_string_literal: true

module Common
  class Commission
    attr_reader :insurance_fee, :assistance_fee, :drivy_fee

    def initialize(insurance_fee:, assistance_fee:, drivy_fee:)
      @insurance_fee = insurance_fee
      @assistance_fee = assistance_fee
      @drivy_fee = drivy_fee
    end

    def ==(other)
      other.class == self.class &&
        insurance_fee == other.insurance_fee &&
        assistance_fee == other.assistance_fee &&
        drivy_fee == other.drivy_fee
    end
    alias eql? ==
  end
end
