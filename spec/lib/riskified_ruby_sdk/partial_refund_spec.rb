require "spec_helper"

RSpec.describe RiskifiedRubySdk::PartialRefund do
  describe ".create" do
    before do
      RiskifiedRubySdk.configure do |c|
        c.auth_token = CONFIG[:auth_token]
        c.shop_domain = CONFIG[:shop_domain]
      end
    end
    it "returns a PartialRefund object", vcr: { record: :once, match_requests_on: %i[method] } do
      client = RiskifiedRubySdk::Client.new(sandbox: true)
      data = {
        order: {
          id: "123456",
          refunds: [
            {
              refund_id: "1235",
              sku: "ABCD004245",
              amount: 10.5,
              refunded_at: "2014-01-10T11:00:00Z",
              currency: "USD",
              reason: "Rebate"
            },
            {
              refund_id: "1238",
              sku: "EFGH008482",
              amount: 22,
              refunded_at: "2014-02-10T11:00:00Z",
              currency: "USD",
              reason: "Product not shipped"
            }
          ]
        }
      }
      partial_refund = described_class.create(
        data,
        client: client
      )

      expect(partial_refund).to be_a(RiskifiedRubySdk::PartialRefund)
    end
  end
end