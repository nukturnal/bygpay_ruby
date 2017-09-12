module Bygpay
  module Deposit
    class Mobile < Bygpay::Deposits

      # Perform a mobile deposit request
      # @param amount [Decimal]
      # @param mobile_data [Hash]
      # mobile data example
      # {
      #     "walletno" : "0276967627",
      #     "provider": "TIGO",
      #     "currency": "USD", # Optional
      #     "token": "393902", # Optional (Only Required for Vodafone Payments)
      #     "extrnx_code": null # Optional
      # }
      def charge(amount, mobile_data = {})
        post(mobile_deposit_endpoint, mobile_data.merge(amount: amount))
      end
    end
  end
end
