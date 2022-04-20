# frozen_string_literal: true

module RiskifiedRubySdk
  class Decide
    class << self
      # Analyzes the order synchronously, the returned status is Riskified's analysis review result (only for merchants
      # with sync flow).
      #
      # Must use https://wh-sync.riskified.com as the production base url for this endpoint only.
      #
      # Production url: https://wh-sync.riskified.com/api/decide.
      # Sandbox url: https://sandbox.riskified.com/api/decide.
      #
      # Refer to the Models section for details on building the model and constructing individual fields.
      #
      # Expected responses will be returned synchronously to the request sent to our API endpoint. Refer to the
      # Notifications section for further information on handling Riskified's response.
      #
      # @param data [Hash] data to send; must include id and status
      # id [String] Unique ID of order being acted upon
      # status [String] Textual status describing the result of the operation. Expected values include:
      #   "approved", "declined", "captured"
      def create(data, client:)
        decide = client.post(path, data).with_indifferent_access
        build decide
      rescue NoMethodError => _e
        Error.new("NoMethodError: #{data}")
      end

      private

      def build(decide)
        order = decide[:order]
        new(order[:id], order[:status], order[:description], order[:old_status], order[:category])
      end

      def path
        "decide"
      end
    end

    def initialize(order_id, order_status, order_description, order_old_status, category)
      @order_id = order_id
      @order_status = order_status
      @order_description = order_description
      @order_old_status = order_old_status
      @category = category
    end
    attr_reader :order_id, :order_status, :order_description, :order_old_status, :category
  end
end
