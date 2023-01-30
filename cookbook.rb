require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes

  def initialize
    @csv_file_path = File.join(__dir__, 'recipes.csv')
    @recipes = []
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:done] = row[:done] == "true"
      @recipes << Recipe.new(row)
    end
  end

  def all
    @recipes
  end

  def write_in_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << ["name", "description", "rating", "prep_time", "done"]
      @recipes.each do |element|
        csv << [element.name, element.description, element.rating, element.prep_time, element.recipe_done?]
      end
    end
  end

  def create(recipe)
    @recipes << recipe
    write_in_csv
  end

  def mark_recipe_as_done_update(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    write_in_csv
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    write_in_csv
  end
end
