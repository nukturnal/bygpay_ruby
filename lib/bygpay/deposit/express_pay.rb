module Bygpay
  module Deposit
    class ExpressPay < Bygpay::Deposits
      # {
      #     "customer_email" : "james.bolie@gmail.com",
      #     "customer_phone": null,
      #     "customer_firstname": null,
      #     "customer_lastname": null,
      #     "custom_logo": null,
      #     "country": "GH",
      #     "currency": "GHS",
      #     "redirect_url": "URL"
      # }
      # Perform ExpressPay Checkout Transaction
      def charge(amount, payload = {})
        post(expresspay_deposit_endpoint, payload.merge(amount: amount))
      end
    end
  end
end