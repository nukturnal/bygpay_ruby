require "bundler/setup"
require "bygpay"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    Bygpay.configure do |c|
      c.base_url = 'https://engine.bygpay.com/api'
      c.api_key = 'e65815c6-6c7f-4cbb-91eb-3cbb0262'
    end

    @mobile_deposit = Bygpay::Deposit::Mobile.new
    @mobile_withdraw = Bygpay::Withdraw::Mobile.new
    @valid_mobile_payload = { walletno: '0244000001', provider: 'MTN' }
    @invalid_mobile_payload = { walletno: '0244000001', provider: 'AREEBA' }

    @card_deposit = Bygpay::Deposit::Card.new
    @valid_card_payload = { card_number: "4111111111111111", amount: 0.10, expiry_month: 6, expiry_year: 2017, cvv: 123 }
    @invalid_card_payload = { card_number: "4111111111111112", amount: 0.10, expiry_month: 6, expiry_year: 2017, cvv: 123 }

    @deposit_amount = 0.50
    @withdraw_amount = 0.50
  end
end
