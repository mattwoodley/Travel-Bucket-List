require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/city.rb')
require_relative('../models/country.rb')
also_reload('../models/*')

get '/cities' do
  @cities = City.all()
  erb(:"cities/index")
end

get '/cities/visited' do
  @visited = City.visits("Visited")
  erb(:"cities/visit_status/visited")
end

get '/cities/want-to-visit' do
  @want_to_visit = City.visits("Want To Visit")
  erb(:"cities/visit_status/want_to_visit")
end

get '/cities/not-visited' do
  @not_visited = City.visits("Not Visited")
  erb(:"cities/visit_status/not_visited")
end

get '/cities/new' do
  @cities = City.all
  @status = ["Visited", "Not Visited", "Want To Visit"]
  @countries = Country.all()
  erb(:"cities/new")
end

post '/cities' do
  City.new(params).save
  redirect('/cities')
end

get '/cities/delete-all-warning' do
  erb(:"/cities/delete_all_warning")
end

get '/cities/:id' do
  @city = City.find(params['id'])
  erb(:"cities/show")
end

get '/cities/:id/edit' do #edit city info
  @city = City.find(params['id'])
  @status = ["Visited", "Not Visited", "Want To Visit"]
  @countries = Country.all()
  erb(:"cities/edit")
end

post '/cities/delete-all' do
  City.delete_all()
  redirect('/cities')
end

post '/cities/:id' do
  city = City.new(params)
  city.update()
  redirect('/cities/' + params['id'].to_s)
end

post '/cities/:id/delete' do
  City.delete(params['id'])
  redirect('/cities')
end
