# frozen_string_literal: true

module RiskifiedRubySdk
  class Chargeback
    class << self

      def create(data, client:)
        chargeback = client.post(path, data).with_indifferent_access
        build chargeback
      rescue NoMethodError => _e
        Error.new("NoMethodError: #{data}, chargeback: #{chargeback}")
      end

      private

      def build(chargeback)
        order = chargeback[:order]
        new(order[:id], order[:status], order[:description], order[:old_status])
      end

      def path
        "chargeback"
      end
    end

    def initialize(order_id, order_status, order_description, order_old_status)
      @order_id = order_id
      @order_status = order_status
      @order_description = order_description
      @order_old_status = order_old_status
    end
    attr_reader :order_id, :order_status, :order_description, :order_old_status
  end
end
