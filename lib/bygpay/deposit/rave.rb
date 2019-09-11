module Bygpay
  module Deposit
    class Rave < Bygpay::Deposits
      # {
      #     "customer_email" : "james.bolie@gmail.com",
      #     "customer_phone": null,
      #     "customer_firstname": null,
      #     "customer_lastname": null,
      #     "custom_title": null,
      #     "custom_logo": null,
      #     "country": "GH",
      #     "currency": "GHS"
      # }
      # Perform a RaveRedirect Transaction
      def charge(amount, payload = {})
        post(rave_deposit_endpoint, payload.merge(amount: amount))
      end
    end
  end
end
