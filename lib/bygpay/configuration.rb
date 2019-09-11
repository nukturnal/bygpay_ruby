module Bygpay
  class Configuration
    attr_accessor :base_url, :api_key,
                  :deposit_mobile_path, :deposit_status_overide_path, :deposit_status_path,
                  :withdraw_mobile_path, :withdraw_status_overide_path, :withdraw_status_path,
                  :deposit_card_path, :deposit_rave_path

    def initialize
      @base_url = nil
      @api_key = nil

      # Preset default paths but allow for changes
      @deposit_mobile_path = '/deposits/mobile'
      @deposit_rave_path = '/deposits/rave-redirect'
      @deposit_card_path = '/deposits/card'
      @deposit_status_overide_path = '/deposits/status-overide'
      @deposit_status_path = '/deposits'

      @withdraw_mobile_path = '/withdrawals/mobile'
      @withdraw_status_overide_path = '/withdrawals/status-overide'
      @withdraw_status_path = '/withdrawals'
    end
  end
end