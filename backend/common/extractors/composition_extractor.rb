# frozen_string_literal: true

module Common
  module Extractors
    class CompositionExtractor
      attr_reader :extractors

      #
      # CompositionExtractor constructors.
      # An extractor is anything with a #call method accepting a rental price
      # and a parent_hash. It should return a hash (possibly the updated parent hash).
      #
      # @param [Array<#call>] extractors
      #
      def initialize(extractors)
        @extractors = extractors
      end

      #
      # Extracts the rental price id.
      #
      # @param [Common::RentalPrice] rental
      # @param [Hash] parent_hash Hash already containing extracted information
      #
      # @return [Hash] parent_hash with the rental price id
      #
      def call(rental_price, parent_hash)
        extractors.reduce(parent_hash) do |h, extractor|
          extractor.call(rental_price, h)
        end
      end
    end
  end
end
