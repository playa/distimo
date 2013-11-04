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
        stub_request(:get,"https://analytics.distimo.com/api/v3/downloads" ).
        with({ headers: {"Authorization" => "Bearer TOKEN"}, query: hash_including({})})
      end
      it "should set auth token" do
        client_with_token.downloads({})
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
        stub_request(:get,"https://user:pass@analytics.distimo.com/api/v3/downloads" ).
        with({ headers: {}, query: hash_including({})})
      end
      it "should set auth token" do
        client_without_token.downloads({})
      end
    end


  end


end
