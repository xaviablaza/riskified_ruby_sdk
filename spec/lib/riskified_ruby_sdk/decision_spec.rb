require "spec_helper"

RSpec.describe RiskifiedRubySdk::Decision do
  describe ".create" do
    before do
      RiskifiedRubySdk.configure do |c|
        c.auth_token = CONFIG[:auth_token]
        c.shop_domain = CONFIG[:shop_domain]
      end
    end
    it "returns a Decision object", vcr: { record: :once, match_requests_on: %i[method] } do
      client = RiskifiedRubySdk::Client.new(sandbox: true)
      data = {
        order: {
          id: "123456",
          decision: {
            external_status: "approved",
            reason: "",
            decided_at: "2022-03-15T13:36:50-04:00",
            notes: "",
            amount: 145,
            currency: "USD"
          },
          gateway: "adyen",
          payment_details: []
        }
      }
      decision = described_class.create(
        data,
        client: client
      )

      expect(decision).to be_a(RiskifiedRubySdk::Decision)
    end
  end
end