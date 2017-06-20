module Bygpay
  module Deposit
    class Mobile < Bygpay::Deposits

      # {
      #     "walletno" : "0276967627",
      #     "provider": "TIGO",
      #     "extrnx_code": null
      # }
      # Perform a mobile deposit request
      def charge(amount, mobile_data = {})
        post(mobile_deposit_endpoint, mobile_data.merge({amount: amount}))
      end
    end
  end
end