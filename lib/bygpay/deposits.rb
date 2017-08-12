module Bygpay
  class Deposits
    include Bygpay::Utils

    def charge; end

    # Return deposit transaction status
    def transaction_status(uuid)
      get_status(deposit_status_endpoint,uuid)
    end
  end
end