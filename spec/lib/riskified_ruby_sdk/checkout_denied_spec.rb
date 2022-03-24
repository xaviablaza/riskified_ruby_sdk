require "spec_helper"

RSpec.describe RiskifiedRubySdk::CheckoutDenied do
  describe ".create" do
    before do
      RiskifiedRubySdk.configure do |c|
        c.auth_token = CONFIG[:auth_token]
        c.shop_domain = CONFIG[:shop_domain]
      end
    end
    it "returns a CheckoutDenied object", vcr: { record: :once, match_requests_on: %i[method] } do
      client = RiskifiedRubySdk::Client.new(sandbox: true)
      data = {
        checkout: {
          id: "1234563",
          payment_details: [
            {
              credit_card_bin: "414049",
              avs_result_code: "A", # What are the possible avs_result_codes?
              cvv_result_code: "M", # What are the possible cvv_result_codes?
              credit_card_number: "XXXX-XXXX-XXXX-4242",
              credit_card_company: "Visa",
              authorization_error: {
                created_at: "2022-03-15T11:00:00-05:00",
                error_code: "2001",
                message: "Card was denied."
              }
            }
          ]
        }
      }
      checkout_denied = described_class.create(
        data,
        client: client
      )

      expect(checkout_denied).to be_a(RiskifiedRubySdk::CheckoutDenied)
    end
    it "returns an already decided error", vcr: { record: :once, match_requests_on: %i[method] } do
      client = RiskifiedRubySdk::Client.new(sandbox: true)
      data = {
        checkout: {
          id: "123456",
          payment_details: [
            {
              credit_card_bin: "414049",
              avs_result_code: "A", # What are the possible avs_result_codes?
              cvv_result_code: "M", # What are the possible cvv_result_codes?
              credit_card_number: "XXXX-XXXX-XXXX-4242",
              credit_card_company: "Visa",
              authorization_error: {
                created_at: "2022-03-15T11:00:00-05:00",
                error_code: "2001",
                message: "Card was denied."
              }
            }
          ]
        }
      }
      error = described_class.create(
        data,
        client: client
      )

      expect(error).to be_a(RiskifiedRubySdk::Error)
    end
  end
end