require "helper"

describe Distimo::Client do

  describe "#initialize" do
    subject{
      Distimo::Client.new(private_key: "PrK",
                          public_key: "PubK",
                          token: "T",
                          username: "UN",
                          password: "P")
    }

    its(:private_key){should eq("PrK")}
    its(:public_key){should eq("PubK")}
    its(:token){should eq("T")}
    its(:username){should eq("UN")}
    its(:password){should eq("P")}
  end

  describe "auth" do
    context "with token" do
      let(:client_with_token){
        Distimo::Client.new(private_key: "PrK",
                            public_key: "PubK",
                            token: "TOKEN",
                            username: "UN",
                            password: "P")
      }
      before do
        stub_get("/any").
        with({ headers: {"Authorization" => "Bearer TOKEN"}, query: hash_including({})})
      end
      it "should set auth token" do
        client_with_token.get("/any",{})
      end
    end

    context "without token" do
      let(:client_without_token){
        Distimo::Client.new(private_key: "PrK",
                            public_key: "PubK",
                            username: "user",
                            password: "pass")
      }
      before do
        stub_request(:get,"https://user:pass@analytics.distimo.com/api/v3/any" ).
        with({ headers: {}, query: hash_including({})})
      end
      it "should use basic auth" do
        client_without_token.get("/any",{})
      end
    end
  end

  describe "#get" do
    let(:client){
        Distimo::Client.new(private_key: "PrivateKey",
                            public_key: "PublicKey",
                            token: "TOKEN")
    }
    let(:time){ Time.utc(2000) }
    before do
      Timecop.freeze(time)
    end

    after do
      Timecop.return
    end

    it "has apikey in query" do
      stub_get("/any").with(query: hash_including({apikey: "PublicKey"}))
      client.get("/any",{})
    end
    it "has time in query" do
      stub_get("/any").with(query: hash_including({t: time.to_i.to_s}))
      client.get("/any",{})
    end
    it "has time in query" do
      stub_get("/any").with(query: hash_including(
        foo: "bar",
        hash: OpenSSL::HMAC.hexdigest('sha1', "PrivateKey", "foo=bar" + time.to_i.to_s)))
      client.get("/any",{foo: "bar"})
    end

    context "with error" do
      before do
        stub_get("/any").with(query: hash_including({apikey: "PublicKey"})).
          to_return(:body => {code: 400, message: "Error"}, :status => 400)
      end

      it { expect{ client.get("/any",{})}.to raise_error(Distimo::Error)}
    end
  end
end
