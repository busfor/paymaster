# Paymaster

Ruby wrapper for Paymaster.ua API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paymaster'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paymaster

## Usage

First, you need to initialize paymaster client:

```ruby
client = Paymaster::Client.new(merchant_id: 123, secret_key: "secret")
# => #<Paymaster::Client:0x007fec5a153670 @merchant_id=123, @secret_key="secret">
```

Then you can generate payment link:

```ruby
url = client.generate_url(amount: 150, description: "Test", number: "7654321")
# => "https://lmi.paymaster.ua/index/get?LMI_MERCHANT_ID=123&LMI_PAYMENT_AMOUNT=150&LMI_PAYMENT_NO=7654321&LMI_PAYMENT_DESC=Test&LMI_HASH=473035659648C1F3AF99F1E2E7B1A2863144916C908AE990C5E8F42EF2577465"
```

Fetch information about existing transaction:

```ruby
transaction = client.get_transaction(payment_id: 7654322)
# => #<Paymaster::GetTransaction::Response:0x007fec5f16a550
#  @amount=#<BigDecimal:7fec5a7f0bb8,'0.15E3',9(18)>,
#  @bank_id=0,
#  @data={...},
#  @description="Test",
#  @merchant_comission=#<BigDecimal:7fec5f16a668,'0.0',9(18)>,
#  @mode=1,
#  @number=7654322,
#  @paid_amount=#<BigDecimal:7fec5f16a6b8,'0.15E3',9(18)>,
#  @payer_comission=#<BigDecimal:7fec5f16a618,'0.0',9(18)>,
#  @payer_email=nil,
#  @payer_identifier=0,
#  @payer_phone=nil,
#  @paymaster_id=18777185,
#  @payment_date=Sun, 06 Dec 2015 18:06:34 EET +02:00,
#  @payment_system=18,
#  @state=1>
```

Or perform a refund:

```ruby
refund = client.refund(paymaster_id: 18777185, total: 150, refund_amount: 100, refund_id: 76543212)
# => #<Paymaster::Refund::Response:0x007fec5b861a10 @code=600, @data={"ResultCode"=>"600", "ResultMsg"=>"Возмещение успешно совершено"}, @message="Возмещение успешно совершено">
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kirillplatonov/paymaster. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
