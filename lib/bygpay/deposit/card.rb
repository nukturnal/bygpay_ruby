module Bygpay
  module Deposit
    class Card < Bygpay::Deposits
      # {
      #     "card_number" : "4111111111111111",
      #     "expiry_month": 6,
      #     "expiry_year": 2017,
      #     "cvv": 618,
      #     "country": "GH",
      #     "currency": "GHS"
      # }
      # Perform a Bankcard debit request
      def charge(amount, card_data = {})
        post(card_deposit_endpoint, card_data.merge(amount: amount))
      end
    end
  end
end
