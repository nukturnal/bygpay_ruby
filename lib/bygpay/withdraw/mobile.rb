module Bygpay
  module Withdraw
    class Mobile < Bygpay::Withdrawals
      # {
      #     "walletno" : "0276967627",
      #     "provider": "TIGO",
      #     "extrnx_code": null
      # }
      # Perform a mobile deposit request
      def sendmoney(amount, payload = {})
        post(mobile_withdraw_endpoint, payload.merge(amount: amount))
      end
    end
  end
end
