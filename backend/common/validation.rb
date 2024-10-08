# frozen_string_literal: true

module Common
  #
  # This modules contains validation functions used in internal models.
  # It should be considered an implementation details.
  #
  module Validation
    class Error < Common::Error; end

    #
    # Validates that the value is greater or equal than 0.
    #
    # @param [Integer] value
    # @param [String, nil] error_message Optional custom error message
    #
    # @raise [Common::Validation::Error] when value < 0
    #
    def self.non_neg_integer!(value, error_message = nil)
      return if value >= 0

      error_message ||= "Value <#{value}> should be greater or equal than 0"
      raise Error, error_message
    end

    #
    # Validates that the value is between 0 and 100 (inclusive)
    #
    # @param [Integer] value
    # @param [String, nil] error_message Optional custom error message
    #
    # @raise [Common::Validation::Error] when value < 0 or value > 100
    #
    def self.percentage(value, error_message = nil)
      return if value >= 0 && value <= 100

      error_message ||= "Value <#{value}> should be in [0, 100]"
      raise Error, error_message
    end
  end
end
