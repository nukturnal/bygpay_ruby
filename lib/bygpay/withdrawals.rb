module Bygpay
  class Withdrawals
    include Bygpay::Utils

    def sendmoney; end

    # Return deposit transaction status
    def transaction_status(uuid)
      get_status(withdraw_status_endpoint, uuid)
    end
  end
end
