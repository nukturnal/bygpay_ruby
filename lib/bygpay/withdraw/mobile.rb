module Bygpay
  module Withdraw
    class Mobile < Bygpay::Withdrawals

      # {
      #     "walletno" : "0276967627",
      #     "amount": 0.10,
      #     "provider": "TIGO",
      #     "extrnx_code": null
      # }
      # Perform a mobile deposit request
      def charge(amount, payload ={})
        post(mobile_withdraw_endpoint, payload.merge({amount: amount}))
      end

      # Return deposit transaction status
      def transaction_status(uuid)
        get_status(withdraw_status_endpoint,uuid)
      end

    end
  end
end