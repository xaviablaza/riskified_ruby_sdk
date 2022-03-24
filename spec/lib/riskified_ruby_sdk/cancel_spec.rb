require "spec_helper"

RSpec.describe RiskifiedRubySdk::Cancel do
  describe ".create" do
    before do
      RiskifiedRubySdk.configure do |c|
        c.auth_token = CONFIG[:auth_token]
        c.shop_domain = CONFIG[:shop_domain]
      end
    end
    it "returns a Cancel object", vcr: { record: :once, match_requests_on: %i[method] } do
      client = RiskifiedRubySdk::Client.new(sandbox: true)
      data = {
        order: {
          id: "123456",
          cancel_reason: "Product out of stock",
          cancelled_at: "2022-03-15T11:00:00Z"
        }
      }
      cancel = described_class.create(
        data,
        client: client
      )

      expect(cancel).to be_a(RiskifiedRubySdk::Cancel)
    end
  end
end