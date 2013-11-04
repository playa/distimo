module Distimo
  class Error < StandardError
    attr_reader :code, :note, :link

    def initialize code,note,link
       @code = code
       @note = note
       @link = link
       super("Code: #{code}. #{note} See: #{link}")
    end

    def self.from_response body={}
      new(body["code"],body["message"],body["link"])
    end
  end
end
