module Bygpay
  class Configuration
    attr_accessor :base_url, :api_key,
                  :deposits_mobile_path, :deposits_status_overide_path, :deposit_status_path

    def initialize
      @base_url = nil
      @api_key = nil

      # Preset default paths but allow for changes
      @deposits_mobile_path = '/deposits/mobile'
      @deposits_status_overide_path = '/deposits/status-overide'
      @deposit_status_path = '/deposits'
    end
  end
end