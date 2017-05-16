module Bygpay
  module Deposit
    class Mobile < Bygpay::Deposits

      # {
      #     "walletno" : "0276967627",
      #     "amount": 0.10,
      #     "provider": "TIGO",
      #     "extrnx_code": null
      # }
      def charge(amount, payload ={})
        post(mobile_endpoint, payload.merge({amount: amount}))
      end

      # Return transaction status
      def transaction_status(uuid)
        get_status(deposits_status_endpoint,uuid)
      end

    end
  end
end