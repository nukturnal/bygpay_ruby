require 'http'

module Bygpay
  module Utils
    extend self

    attr_accessor :status, :response_text, :transaction_id, :uuid, :result, :response

    def mobile_endpoint
      Bygpay.configuration.deposits_mobile_path
    end

    def deposits_status_endpoint
      Bygpay.configuration.deposit_status_path
    end

    def post(endpoint, payload = {})
      url = "#{Bygpay.configuration.base_url}#{endpoint}"
      p url
      p payload

      result = http_connect.post(url, json: payload)

      parse_response(result.body)
    end

    def get_status(endpoint, uuid)
      url = "#{Bygpay.configuration.base_url}#{endpoint}"
      p url
      result = http_connect.get("#{url}/#{uuid}")

      parse_response(result.body)
    end

    def parse_response(body)
      result = JSON.parse(body)
      @result = result
      @transaction_id = result['data']['trnx_code']
      @response_text = result['message']
      @uuid = result['data']['uuid']
      @status = result['data']['status']
      @response = result['status'] == 'success' ? true : false
    end

    def http_connect
      HTTP[Authorization: Bygpay.configuration.api_key]
    end
  end
end