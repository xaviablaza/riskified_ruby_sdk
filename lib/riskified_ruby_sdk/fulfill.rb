# frozen_string_literal: true

module RiskifiedRubySdk
  class Fulfill
    class << self

      def create(data, client:)
        fulfill = client.post(path, data).with_indifferent_access
        build fulfill
      rescue NoMethodError => _e
        Error.new("NoMethodError: #{data}")
      end

      private

      def build(fulfill)
        order = fulfill[:order]
        new(order[:id], order[:status])
      end

      def path
        "fulfill"
      end
    end

    def initialize(order_id, order_status)
      @order_id = order_id
      @order_status = order_status
    end
    attr_reader :order_id, :order_status
  end
end
