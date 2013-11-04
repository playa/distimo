require "helper"

describe Distimo::Error do
  describe ".from_response" do
    subject {
      Distimo::Error.from_response({"http_code"=>401,
        "code"=>201,
        "message"=>"Please authenticate API keys.",
        "link"=>"https://analytics.distimo.com/support/api/v3/code/201"})
    }
    its(:code){ should eq(201)}
    its(:note){ should eq("Please authenticate API keys.")}
    its(:message){ should eq("Code: 201. Please authenticate API keys. See: https://analytics.distimo.com/support/api/v3/code/201")}
    its(:link){ should eq("https://analytics.distimo.com/support/api/v3/code/201")}
    its(:class){ should <= StandardError }
  end

end
