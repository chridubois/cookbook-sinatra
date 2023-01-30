class Recipe
  attr_reader :name, :description, :rating, :prep_time
  attr_accessor :is_recipe_done

  def initialize(name, description, rating, prep_time, is_recipe_done = "[ ]")
    @name = name
    @description = description
    @rating = rating
    @is_recipe_done = "[ ]"
    @prep_time = prep_time
  end

  def recipe_done?
    @is_recipe_done
  end

  def mark_as_done
    @is_recipe_done = "[X]"
  end
end
