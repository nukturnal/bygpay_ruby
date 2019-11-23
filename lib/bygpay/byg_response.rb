require 'hashie'

module Bygpay
  class BygResponse
    SUCCESS = 'success'
    FAILED = 'fail'
    PENDING = %w(accepted pending)

    attr_accessor :data

    def initialize(hash = {})
      @data = Hashie::Mash.new(hash)
    end

    # Check if Bygpay Gateway processed requests without any issues
    def request_successful?
      data.status == SUCCESS
    end

    def success?
      data.data.status == SUCCESS
    end

    def failed?
      data.data.status == FAILED
    end

    def pending?
      PENDING.include?(data.data.status)
    end

    def uuid
      data.data.uuid
    end

    def transaction_id
      data.data.trnx_code
    end

    def processor_transaction_id
      data.data.provider_txid
    end

    def transaction_status
      data.data.status
    end

    def currency
      data.data.currency
    end

    def amount
      data.data.amount
    end

    def provider
      data.data.provider
    end

    def redirect_link
      data.data.redirect_url
    end

    # Hash strucuture
    # {
    #     "status": "success",
    #     "message": "Some messages",
    #     "data": {
    #         "uuid": "d1f3395e-ea08-4599-b8a5-41f5e7a4",
    #         "status": "accepted",
    #         "currency": "GHS",
    #         "trnx_code": "DTX00000008",
    #         "provider_txid": null,
    #         "extrnx_code": null,
    #         "walletno": "0276967627",
    #         "amount": 0.1,
    #         "provider": "TIGO"
    #     }
    # }
    # This may throw JSON::ParserError if the json_payload is not valid JSON.
    def self.parse_response(json_payload)
      data = JSON.parse(json_payload, symbolize_names: true)
      resp = BygResponse.new(data)
      resp
    end
  end
end