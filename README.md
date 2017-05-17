# Bygpay

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

  # Optional Configurations 
  # (In case you've changed routes in your Bygpay Installation)
  config.deposits_mobile_path = '/deposits/mobile'
  config.deposits_status_overide_path = '/deposits/status-overide'
  config.deposit_status_path = '/deposits'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bygpay. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

