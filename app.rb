require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'
require_relative 'scraprecipeservice'
require_relative 'scrapeallrecipesservice'

set :bind, "0.0.0.0"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get "/" do
  @cookbook = Cookbook.new
  @recipes = @cookbook.recipes
  erb :index
end

get "/new" do
  erb :new
end

get "/import" do
  erb :import
end

get "/mark_as_done" do
  @cookbook = Cookbook.new
  index = params['index'].to_i
  @cookbook.mark_recipe_as_done_update(index)
  binding.pry
  @recipes = @cookbook.recipes
  break
  redirect to "/"
end

post "/recipes" do
  @cookbook = Cookbook.new
  name = @params['name']
  description = @params['description']
  rating = @params['rating']
  prep_time = @params['prep_time']
  recipe = Recipe.new(name, description, rating, prep_time)
  @cookbook.create(recipe)
  @recipes = @cookbook.recipes
  redirect to "/"
end

post "/recipe_from_web" do
  @keyword = @params['keyword']
  @list = ScrapeAllrecipesService.new(@keyword).call
  erb :suggestions
end

get "/save" do
  @url = @params['url']
  @scrap = ScrapeRecipeService.new(@url)
  @recipe = Recipe.new(@scrap.name, @scrap.description, @scrap.rating, @scrap.prep_time)
  @cookbook = Cookbook.new
  @cookbook.create(@recipe)
  @recipes = @cookbook.recipes
  redirect to "/"
end

get "/destroy" do
  @cookbook = Cookbook.new
  index = params['index'].to_i
  @cookbook.destroy(index)
  @recipes = @cookbook.recipes
  redirect to "/"
end
