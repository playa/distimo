require 'helper'

describe Distimo::API do
  subject{
    Distimo::Client.new(private_key: "PrK",
                        public_key: "PubK",
                        token: "T",
                        username: "UN",
                        password: "P")
    }
  Distimo::API::METHODS.each do |method|
    describe "##{method}" do
      before do
        stub_request(:get,"https://analytics.distimo.com/api/v3/#{method}").
        with(query: hash_including({"a" => "b"}))
      end
      it{ subject.send(method,{a: "b"}) }
    end
  end
end
