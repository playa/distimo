require "distimo/api"
require  "distimo/error"
require "httparty"
module Distimo
  class Client
    include HTTParty
    include Distimo::API
    base_uri 'https://analytics.distimo.com/api/v3/'

    attr_accessor :public_key, :private_key, :username, :password, :token

    def initialize opts
      opts.each {|k,v| send("#{k}=",v)}
    end

    def get path, query
      options = prepare(query)
      response = self.class.get path, options
      raise Error.from_response(response.body) if response.code >= 400
      response
    end

    private

    def prepare query
      time = Time.now.utc.to_i
      hash  = prepare_hash query,time
      _query = query.merge(apikey: public_key, hash: hash, t: time)
      _auth = prepare_auth
      {query: _query}.merge(_auth)
    end

    def prepare_hash query,time
      _query = query.map{|k,v| "#{k}=#{v}"}.join("&")
      OpenSSL::HMAC.hexdigest('sha1', private_key, _query + time.to_s)
    end

    def prepare_auth
      if token
        {headers: {"Authorization" => "Bearer #{token}"}}
      else
        {basic_auth: {:username => username, :password => password}}
      end
    end

  end
end
