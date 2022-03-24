# frozen_string_literal: true

module RiskifiedRubySdk
  class PartialRefund
    class << self

      def create(data, client:)
        partial_refund = client.post(path, data).with_indifferent_access
        build partial_refund
      end

      private

      def build(partial_refund)
        order = partial_refund[:order]
        new(order[:id], order[:status], order[:description], order[:old_status], order[:warnings])
      end

      def path
        "cancel"
      end
    end

    def initialize(order_id, order_status, order_description, order_old_status, order_warnings)
      @order_id = order_id
      @order_status = order_status
      @order_description = order_description
      @order_old_status = order_old_status
      @order_warnings = order_warnings
    end
    attr_reader :order_id, :order_status, :order_description, :order_old_status, :order_warnings
  end
end
