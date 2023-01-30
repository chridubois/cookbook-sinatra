class Recipe
  attr_reader :name, :description, :rating, :prep_time
  attr_accessor :is_recipe_done

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
  end

  def recipe_done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
