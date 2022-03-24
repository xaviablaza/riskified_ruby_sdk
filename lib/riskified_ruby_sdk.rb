# frozen_string_literal: true

require "gem_config"
require "riskified_ruby_sdk/version"
require "riskified_ruby_sdk/client"
require "riskified_ruby_sdk/decide"
require "riskified_ruby_sdk/checkout_denied"
require "riskified_ruby_sdk/decision"
require "riskified_ruby_sdk/fulfill"
require "riskified_ruby_sdk/cancel"
require "riskified_ruby_sdk/partial_refund"
require "riskified_ruby_sdk/error"
require "riskified_ruby_sdk/chargeback"


require_relative "riskified_ruby_sdk/version"

module RiskifiedRubySdk
  include GemConfig::Base

  with_configuration do
    has :auth_token, classes: String
    has :shop_domain, classes: String
  end
end
