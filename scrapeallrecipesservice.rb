require "nokogiri"
require "open-uri"

class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # TODO: return a list of `Recipe` built from scraping the web.
    suggested_recipes = []
    doc = Nokogiri::HTML.parse(URI.open("https://www.allrecipes.com/search?q=#{@keyword}"))
    card_doc = doc.search(".comp.mntl-card-list-items")
    card_doc.each do |element|
      if element.search(".recipe-card-meta__rating-count-text").text.strip == "Ratings"
        suggested_recipes << [element.search(".card__title-text").text.strip, element["href"]]
      end
    end
    return suggested_recipes
  end
end
