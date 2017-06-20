[![Gem Version](https://badge.fury.io/rb/bygpay.svg)](https://badge.fury.io/rb/bygpay) [![Code Climate](https://codeclimate.com/github/nukturnal/bygpay/badges/gpa.svg)](https://codeclimate.com/github/nukturnal/bygpay) [![codebeat badge](https://codebeat.co/badges/8db86406-18f8-4c2d-bacf-58ac1c700c0a)](https://codebeat.co/projects/github-com-nukturnal-bygpay-master) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/7425ac54e6484723a5482a92fc7f35ef)](https://www.codacy.com/app/nukturnal/bygpay?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=nukturnal/bygpay&amp;utm_campaign=Badge_Grade)

# Bygpay Ruby SDK

Ruby wrapper around Bygpay Payment Gateway. Bygpay is a self hosted payment processing gateway which gives merchants / business better flexiblity and control when it comes to payment processing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bygpay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bygpay

## Usage

Setup few configs before use. If you using Rails you can put this in your `initializers` directory eg `initializers/bygpay.rb`

```ruby
Bygpay.configure do |config|
  config.base_url = 'http://gateway.bygpay-server.com/api'
  config.api_key = '8b4e5a9c-6eba-4cdd-94b6-65e6b514'

  # Optional Configurations (Every code below this line)
  # (In case you've changed routes in your Bygpay Installation)
  config.deposit_mobile_path = '/deposits/mobile'
  config.deposit_status_overide_path = '/deposits/status-overide'
  config.deposit_status_path = '/deposits'
  
  config.withdraw_mobile_path = '/withdrawals/mobile'
  config.withdraw_status_overide_path = '/withdrawals/status-overide'
  config.withdraw_status_path = '/withdrawals'
end
```

## Transaction Statuses

Bygpay gateway uses four types of status messages to mark transactions.
* `accepted` A transaction is marked as `accepted` when it's initially receives the request from a client
* `pending` A transaction is marked a `pending` when the Gateway begins processing
* `success` A final status message `success` is used when processing completes successfully
* `fail` A final status message `fail' is used when the processing completes unsuccessfully

## Deposit Requests

#### Mobile Money

Currently SDK supports MTN, AIRTEL, TIGO, VODAFONE, you may refer to your Bygpay Gateway documentations for more provider options. 

Mobile Money transactions are not onetime requests because of their inherent nature, need to rely on checking the transaction status or callback POST from Bygpay Gateway to verify the status of the transaction. 

```ruby
# Making a Mobile Money Deposit Request
deposit = Bygpay::Deposit::Mobile.new
result = deposit.charge(1.99,{walletno: '0244124550', provider: 'MTN'})
if result
  puts deposit.uuid
  puts deposit.status # accepted, :pending, :fail, :success
  puts deposit.transaction_id
else
  puts deposit.response_text
  puts deposit.status
end
```

Query Transaction status
```ruby
# Checking transaction status
# You always need the transaction UUID to get status response
deposit = Bygpay::Deposit::Mobile.new
result = deposit.transaction_status('e81216aa-9ef7-4c5c-aed0-6e5ff1fe')
if result
  puts deposit.uuid # need uuid to check transacion status
  puts deposit.status # accepted, :pending, :fail, :success
  puts deposit.transaction_id
else
  puts deposit.response_text
  puts deposit.status
end
```
#### Debit/Credit Card

Supports VISA, MasterCard and any other cards based on the processors available on Bygpay Gateway. This is a onetime transaction and immediate response is the final status of the transaction. However transaction status request is still available

```ruby
# Making a Mobile Money Deposit Request
# Please note that some of the optional fields might be required base on 
# which processors the BygPay Gateway is using.
deposit = Bygpay::Deposit::Card.new
card_data = { 
  card_number: '4111111111111111', 
  amount: 0.10, 
  expiry_month: 6, 
  expiry_year: 2017, 
  cvv: 123,
  country: 'GH', # Optional country ISO code
  currency: 'USD', # Optional currency ISO code
  card_name: 'Gifty Cobbinah' # Optional Card Hold Name
}
result = deposit.charge(1.99, card_data)
if result
  puts deposit.uuid
  puts deposit.status # accepted, :pending, :fail, :success
  puts deposit.transaction_id
else
  puts deposit.response_text
  puts deposit.status
end
```

Query Transaction status
```ruby
# Checking transaction status
# You always need the transaction UUID to get status response
deposit = Bygpay::Deposit::Card.new
result = deposit.transaction_status('e81216aa-9ef7-4c5c-aed0-6e5ff1fe')
if result
  puts deposit.uuid
  puts deposit.status # accepted, :pending, :fail, :success
  puts deposit.transaction_id
else
  puts deposit.response_text
  puts deposit.status
end
```

## Withdraw Requests

#### Mobile Money

Currently SDK supports MTN, AIRTEL, TIGO, VODAFONE, you may refer to your Bygpay Gateway documentations for more provider options.

```ruby
# Making a Mobile Money Withdrawal Request
withdraw = Bygpay::Withdraw::Mobile.new
result = withdraw.send(1.99,{walletno: '0244124550', provider: 'MTN'})
if result
  puts withdraw.uuid
  puts withdraw.status # accepted, :pending, :fail, :success
  puts withdraw.transaction_id
else
  puts withdraw.response_text
  puts withdraw.status
end
```

Query Transaction status
```ruby
# Checking transaction status
# You always need the transaction UUID to get status response
withdraw = Bygpay::Withdraw::Mobile.new
result = withdraw.transaction_status('e81216aa-9ef7-4c5c-aed0-6e5ff1fe')
if result
  puts withdraw.uuid
  puts withdraw.status # accepted, :pending, :fail, :success
  puts withdraw.transaction_id
else
  puts withdraw.response_text
  puts withdraw.status
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nukturnal/bygpay_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

