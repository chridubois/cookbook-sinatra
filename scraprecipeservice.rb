require "nokogiri"
require "open-uri"

class ScrapeRecipeService
  attr_accessor :name, :description, :rating, :prep_time

  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML.parse(URI.open(@url))
    @name = @doc.search("h1").text.strip
    @description = @doc.search(".comp.type--dog.article-subheading").text.strip
    @rating = @doc.search(".comp.type--squirrel-bold.mntl-recipe-review-bar__rating.mntl-text-block").text.strip
    @prep_time = @doc.search(".mntl-recipe-details__value")[0].text.strip
  end
end
