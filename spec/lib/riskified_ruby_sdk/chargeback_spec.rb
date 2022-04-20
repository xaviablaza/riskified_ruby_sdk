require "spec_helper"

RSpec.describe RiskifiedRubySdk::Chargeback do
  describe ".create" do
    before do
      RiskifiedRubySdk.configure do |c|
        c.auth_token = CONFIG[:auth_token]
        c.shop_domain = CONFIG[:shop_domain]
      end
    end
    it "returns a Chargeback object", vcr: { record: :once, match_requests_on: %i[method] } do
      client = RiskifiedRubySdk::Client.new(sandbox: true)
      data = {
        order: {
          id: "123456",
          chargeback_details: {
            id: "15673",
            chargeback_at: "2016-06-10T15:46:51Z",
            chargeback_currency: "USD",
            chargeback_amount: 50.5,
            reason_code: "4863",
            type: "cb",
            gateway: "braintree",
            reason_description: "Transaction not recognised",
            mid: "t_123",
            arn: "a123456789012bc3de45678901f23a45",
            credit_card_company: "visa",
            respond_by: "2016-09-01",
            card_issuer: "Wells Fargo Bank"
          },
          fulfillment: {
            fulfillment_id: "12asf123",
            created_at: "2013-04-23T13:36:50-04:00",
            status: "success",
            tracking_company: "fedex",
            tracking_numbers: "abc123"
          },
          dispute_details: {
            case_id: "a1234",
            status: "won",
            disputed_at: "2017-06-01",
            expected_resolution_date: "2017-07-15",
            dispute_type: "first_dispute"
          }
        }
      }
      chargeback = described_class.create(
        data,
        client: client
      )

      expect(chargeback).to be_a(RiskifiedRubySdk::Chargeback)
    end
  end
end