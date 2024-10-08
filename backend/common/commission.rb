# frozen_string_literal: true

module Common
  class Commission
    attr_reader :insurance_fee, :assistance_fee, :drivy_fee

    #
    # Commission associated to various actors.
    #
    # @param [Integer] insurance_fee Insurance fee in cents
    # @param [Integer] assistance_fee Road assistance fee in cents
    # @param [Integer] drivy_fee GetAround fee in cents
    #
    # @raise [Common::Validation::Error] When any input is invalid
    #
    def initialize(insurance_fee:, assistance_fee:, drivy_fee:)
      @insurance_fee = insurance_fee
      @assistance_fee = assistance_fee
      @drivy_fee = drivy_fee

      validate!
    end

    def ==(other)
      other.class == self.class &&
        insurance_fee == other.insurance_fee &&
        assistance_fee == other.assistance_fee &&
        drivy_fee == other.drivy_fee
    end
    alias eql? ==

    private

    def validate!
      Validation.non_neg_integer!(insurance_fee,
                                  "insurance_fee is negative <#{insurance_fee}>")
      Validation.non_neg_integer!(assistance_fee,
                                  "assistance_fee is negative <#{assistance_fee}>")
      Validation.non_neg_integer!(drivy_fee,
                                  "drivy_fee is negative <#{drivy_fee}>")
    end
  end
end
