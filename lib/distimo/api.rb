module Distimo
  module API
    METHODS = [:downloads, :revenues, :ads, :rankings, :ratings, :reviews, :events, :leaderboards]

    METHODS.each do |name|
      define_method name do |query = {}|
        options = prepare(query)
        self.class.get("/#{name}", options)
      end
    end

  end
end
