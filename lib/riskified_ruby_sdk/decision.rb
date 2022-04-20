# frozen_string_literal: true

module RiskifiedRubySdk
  class Decision
    class << self

      def create(data, client:)
        decision = client.post(path, data).with_indifferent_access
        build decision
      rescue NoMethodError => _e
        Error.new("NoMethodError: #{data}")
      end

      private

      def build(decision)
        order = decision[:order]
        new(order[:description], order[:id], order[:old_status], order[:status])
      end

      def path
        "decision"
      end
    end

    def initialize(order_description, order_id, order_old_status, order_status)
      @order_description = order_description
      @order_id = order_id
      @order_old_status = order_old_status
      @order_status = order_status
    end
    attr_reader :order_description, :order_id, :order_old_status, :order_status
  end
end
