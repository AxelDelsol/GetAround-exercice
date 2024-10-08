# frozen_string_literal: true

module Common
  #
  # Extractors are classes converting a (part of) rental price into a hash
  # in order to be serialized.
  #
  module Extractors
  end
end

require_relative 'extractors/id_extractor'
require_relative 'extractors/price_extractor'
require_relative 'extractors/commission_extractor'
require_relative 'extractors/actions_extractor'
require_relative 'extractors/options_extractor'
require_relative 'extractors/composition_extractor'
