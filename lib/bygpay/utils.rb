require 'http'

module Bygpay
  module Utils
    attr_accessor :status, :response_text, :transaction_id,
                  :uuid, :result, :response, :amount

    # Mobile Deposit transactions endpoint
    def mobile_deposit_endpoint
      Bygpay.configuration.deposit_mobile_path
    end

    # Rave Deposit transactions endpoint
    def rave_deposit_endpoint
      Bygpay.configuration.deposit_rave_path
    end

    # Mobile Deposit transactions endpoint
    def card_deposit_endpoint
      Bygpay.configuration.deposit_card_path
    end

    # Deposit transactions status check endpoint
    def deposit_status_endpoint
      Bygpay.configuration.deposit_status_path
    end

    # Mobile Withdrawal transactions endpoint
    def mobile_withdraw_endpoint
      Bygpay.configuration.withdraw_mobile_path
    end

    # Withdraw transactions status check endpoint
    def withdraw_status_endpoint
      Bygpay.configuration.withdraw_status_path
    end

    # Post payload
    def post(endpoint, payload = {})
      url = "#{Bygpay.configuration.base_url}#{endpoint}"
      result = http_connect.post(url, json: payload)

      parse_response(result.body)
    end

    # Get transaction status
    def get_status(endpoint, uuid)
      url = "#{Bygpay.configuration.base_url}#{endpoint}"
      result = http_connect.get("#{url}/#{uuid}")

      parse_response(result.body)
    end

    # Parse on JSON Body to BygResponse for parsing and processing
    def parse_response(json_payload)
      @response = Bygpay::BygResponse.parse_response(json_payload)
      resp = @response.data
      @transaction_id = @response.transaction_id
      @response_text = resp.message
      @uuid = @response.uuid
      @amount = @response.amount
      @status = @response.transaction_status
      @result = @response.request_successful?
    end

    # global Bygpay connect
    def http_connect
      HTTP[Authorization: Bygpay.configuration.api_key]
    end
  end
end