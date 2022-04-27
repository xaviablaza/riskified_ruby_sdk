# frozen_string_literal: true

require "httparty"

module RiskifiedRubySdk
  class Client
    SANDBOX_API_ENDPOINT = "https://sandbox.riskified.com/api"
    PRODUCTION_API_ENDPOINT = "https://wh.riskified.com/api"

    def initialize(sandbox: false)
      @sandbox = sandbox
    end

    # def get(path, headers = default_get_headers)
    #   HTTParty.get(url(path), { headers: headers })
    # end

    def post(path, body = {})
      json_body = body.to_json
      HTTParty.post(url(path), { body: json_body, headers: default_post_headers(json_body) })
    end

    def delete(path, headers = default_delete_headers)
      HTTParty.delete(url(path), { headers: headers })
    end

    private

    # Returns the base url depending on whether client is instantiated in sandbox or production mode
    # @return base_url [String]
    def base_url
      return SANDBOX_API_ENDPOINT if @sandbox

      PRODUCTION_API_ENDPOINT
    end

    # Returns a String with the path appended to the base_url
    # @return url [String]
    def url(path)
      "#{base_url}/#{path}"
    end

    # Returns a String representing the key name of the verification hash
    # @return key_name [String]
    def verification_hash_key_name
      "X-RISKIFIED-HMAC-SHA256"
    end

    # Returns a String representing the key name of the shop domain
    # @return key_name [String]
    def shop_domain_key_name
      "X-RISKIFIED-SHOP-DOMAIN"
    end

    # Returns a Hash(String, String)
    # @return headers [Hash(String, String)]
    # @see https://apiref.riskified.com/curl/#authentication
    # def default_get_headers
    #   {
    #     'ACCEPT' => 'application/vnd.riskified.com; version=2',
    #     'Content-Type' => 'application/json',
    #     shop_domain_key_name => RiskifiedRubySdk.configuration.shop_domain,
    #     verification_hash_key_name => calculate_hash
    #   }
    # end

    def default_post_headers(json_body)
      {
        'ACCEPT' => 'application/vnd.riskified.com; version=2',
        'Content-Type' => 'application/json',
        shop_domain_key_name => RiskifiedRubySdk.configuration.shop_domain,
        verification_hash_key_name => calculate_hash(json_body)
      }
    end

    # Returns the digest for the verification hash
    def hmac_digest
      OpenSSL::Digest.new('sha256')
    end

    # Returns the key that the hash will be calculated with
    def hmac_key
      RiskifiedRubySdk.configuration.auth_token
    end

    # Calculates the verification hash for the request
    # @return sha256_hash [String]
    # @see https://apiref.riskified.com/curl/#authentication
    def calculate_hash(json_body)
      OpenSSL::HMAC.hexdigest(hmac_digest, hmac_key, json_body)
    end
  end
end