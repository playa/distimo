require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.start

require 'distimo'
require 'rspec'
require 'timecop'
require 'webmock/rspec'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end


def stub_get(path)
  stub_request(:get, Distimo::Client.base_uri + path)
end
