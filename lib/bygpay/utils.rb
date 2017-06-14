require 'http'

module Bygpay
  module Utils
    module_function

    attr_accessor :status, :response_text, :transaction_id, :uuid, :result, :response

    # Mobile Deposit transactions endpoint
    def mobile_deposit_endpoint
      Bygpay.configuration.deposit_mobile_path
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
      puts "URL: #{url}"
      result = http_connect.post(url, json: payload)

      parse_response(result.body)
    end

    # Get transaction status
    def get_status(endpoint, uuid)
      url = "#{Bygpay.configuration.base_url}#{endpoint}"
      result = http_connect.get("#{url}/#{uuid}")

      parse_response(result.body)
    end

    # {
    #     "status": "success",
    #     "data": {
    #         "uuid": "d1f3395e-ea08-4599-b8a5-41f5e7a4",
    #         "status": "accepted",
    #         "trnx_code": "DTX00000008",
    #         "provider_txid": null,
    #         "extrnx_code": null,
    #         "walletno": "0276967627",
    #         "amount": 0.1,
    #         "provider": "TIGO"
    #     }
    # }
    def parse_response(body)
      result = JSON.parse(body)
      @result = result
      @transaction_id = result['data']['trnx_code']
      @response_text = result['message']
      @uuid = result['data']['uuid']
      @status = result['data']['status']
      @response = result['status'] == 'success'
    end

    # global Bygpay connect
    def http_connect
      HTTP[Authorization: Bygpay.configuration.api_key]
    end
  end
end