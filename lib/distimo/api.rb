module Distimo
  module API
    METHODS = [:downloads, :revenues, :ads, :rankings, :ratings, :reviews, :events, :leaderboards]

    METHODS.each do |name|
      define_method name do |query = {}|
        get("/#{name}", query)
      end
    end

  end
end
