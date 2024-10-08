# frozen_string_literal: true

module Common
  class Rental
    attr_reader :id, :car, :start_date, :end_date, :distance, :options

    #
    # Rental constructor.
    #
    # @param [Integer] id Identifier
    # @param [Common::Car] car Rented car
    # @param [Date] start_date Start date of the rental
    # @param [Date] end_date End date (inclusive) of the rental
    # @param [Integer] distance Distance driver. Should be >=0
    # @param [Array<Common::DailyOption>, nil] options Additional options, default: []
    #
    # @raise [Common::Validation::Error] When any input is invalid
    #
    def initialize(id:, car:, start_date:, end_date:, distance:, options: nil)
      @id = id
      @car = car
      @start_date = start_date
      @end_date = end_date
      @distance = distance
      @options = options || []

      validate!
    end

    #
    # How many days the rental lasted.
    #
    # @return [Integer] Number of days
    #
    def rental_duration = (end_date - start_date).to_i + 1

    private

    def validate!
      Validation.non_neg_integer!(distance, "distance <#{distance}> is negative")

      validate_range_date!
    end

    def validate_range_date!
      return if start_date <= end_date

      raise Validation::Error,
            "Invalid rental range. Start: #{start_date} // End: #{end_date}"
    end
  end
end
