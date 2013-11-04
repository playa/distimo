# Distimo

Simple api wrapper

## Installation

Add this line to your application's Gemfile:

    gem 'distimo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install distimo

## Usage

```ruby
client = Distimo::Client.new(
  public_key: "your public key",
  private_key: "your private key",
  token: "oauth token",
  username: "your user name",
  password: "your password")

puts client.downloads(assets: "1,2,3")
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
