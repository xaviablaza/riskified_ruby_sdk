# frozen_string_literal: true

module RiskifiedRubySdk
  class CheckoutDenied
    class << self

      def create(data, client:)
        checkout_denied = client.post(path, data).with_indifferent_access
        build checkout_denied
      rescue NoMethodError => _e
        Error.new("NoMethodError: #{data}")
      end

      private

      def build(checkout_denied)
        return Error.new(checkout_denied[:error]) if checkout_denied[:error]

        checkout = checkout_denied[:checkout]
        new(checkout[:id], checkout[:status])
      end

      def path
        "checkout_denied"
      end
    end

    def initialize(checkout_id, checkout_status)
      @checkout_id = checkout_id
      @checkout_status = checkout_status
    end
    attr_reader :checkout_id, :checkout_status
  end
end
