require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes

  def initialize
    @csv_file_path = File.join(__dir__, 'recipes.csv')
    @recipes = []
    CSV.foreach(@csv_file_path) do |row|
      recipe = Recipe.new(row[0], row[1], row[2], row[3], row[4])
      @recipes << recipe
    end
  end

  def all
    @recipes
  end

  def write_in_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each do |element|
        csv << [element.name, element.description, element.rating, element.prep_time, element.is_recipe_done]
      end
    end
  end

  def create(recipe)
    @recipes << recipe
    write_in_csv
  end

  def mark_recipe_as_done_update(index)
    @recipes[index].mark_as_done
    write_in_csv
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    write_in_csv
  end
end
