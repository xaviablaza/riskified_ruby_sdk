# frozen_string_literal: true

module RiskifiedRubySdk
  class Error
    def initialize(message)
      @message = message
    end
    attr_reader :message
  end
end
