require "spec_helper"

RSpec.describe RiskifiedRubySdk::Fulfill do
  describe ".create" do
    before do
      RiskifiedRubySdk.configure do |c|
        c.auth_token = CONFIG[:auth_token]
        c.shop_domain = CONFIG[:shop_domain]
      end
    end
    it "returns a Fulfill object", vcr: { record: :once, match_requests_on: %i[method] } do
      client = RiskifiedRubySdk::Client.new(sandbox: true)
      data = {
        order: {
          id: "123456",
          fulfillments: [
            {
              created_at: "2013-04-23T13:36:50-04:00",
              status: "success",
              tracking_company: "fedex",
              tracking_numbers: "abc123",
              tracking_urls: "http://fedex.com/track?q=abc123",
              message: "estimated delivery 2 days",
              receipt: "authorization: 765656"
            },
            {
              created_at: "2013-04-23T13:36:50-04:00",
              status: "failure",
              message: "item out of stock"
            }
          ]
        }
      }
      fulfill = described_class.create(
        data,
        client: client
      )

      expect(fulfill).to be_a(RiskifiedRubySdk::Fulfill)
    end
  end
end