module Bygpay
  module Deposit
    class Hubtel < Bygpay::Deposits
      # {
      #     "customer_email" : "james.bolie@gmail.com",
      #     "customer_phone": null,
      #     "customer_firstname": null,
      #     "customer_lastname": null,
      #     "custom_logo": null,
      #     "country": "GH",
      #     "currency": "GHS",
      #     "redirect_url": "URL"
      #     "description": "Payment info"
      # }
      # Perform Hubtel Checkout Transaction
      def charge(amount, payload = {})
        post(hubtel_deposit_endpoint, payload.merge(amount: amount))
      end
    end
  end
end