require "spec_helper"

RSpec.describe RiskifiedRubySdk::Decide do
  describe ".create" do
    before do
      RiskifiedRubySdk.configure do |c|
        c.auth_token = CONFIG[:auth_token]
        c.shop_domain = CONFIG[:shop_domain]
      end
    end
    it "returns a Decide object", vcr: { record: :once, match_requests_on: %i[method] } do
      client = RiskifiedRubySdk::Client.new(sandbox: true)
      data = {
        order: {
          id: "123456",
          email: "test@approve.com",
          created_at: "2022-03-15T08:17:00Z", # Time.current.iso8601
          currency: "USD",
          gateway: "adyen",
          browser_ip: "183.34.15.26",
          total_price: 145,
          total_discounts: nil,
          note: " ",
          vendor_name: "My Vendor",
          source: "desktop_web",
          submission_reason: "submitted",
          discount_codes: [
            {
              amount: 10,
              code: "NewUSER"
            }
          ],
          line_items: [
            {
              price: 150,
              requires_shipping: true,
              quantity: 1,
              title: "New great product!",
              sku: "dfn239mndf9",
              category: "On Sale",
              brand: "Lovely Products",
              product_type: "physical"
            }
          ],
          shipping_address: {
            first_name: "John",
            last_name: "Test",
            company: "outlook",
            country: "USA",
            address1: "123 smart st",
            address2: "2",
            city: "Los Angeles",
            province: "California",
            zip: "90210"
          },
          billing_address: {
            first_name: "John",
            last_name: "Test",
            company: "outlook",
            country: "USA",
            address1: "123 smart st",
            address2: "2",
            city: "Los Angeles",
            province: "California",
            zip: "90210"
          },
          client_details: nil,
          shipping_lines: [
            {
              price: 5,
              title: "standard",
              company: "Deliveries INC"
            }
          ],
          customer: {
            email: "test@mailmail.com",
            verified_email: nil,
            first_name: "John",
            last_name: "Test",
            id: "d8fjv234",
            created_at: "2020-04-15T08:17:00Z",
            orders_count: 11,
            account_type: "registered",
            phone: "+143873984567290"
          },
          payment_details: [
            {
              credit_card_bin: "456789",
              credit_card_number: "xxxx-xxxx-xxxx-9876",
              credit_card_company: "VISA"
            }
          ]
        }
      }
      decide = described_class.create(
        data,
        client: client
      )

      expect(decide).to be_a(RiskifiedRubySdk::Decide)
    end
  end
end