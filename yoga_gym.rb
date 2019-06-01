require( 'sinatra' )
require( 'sinatra/contrib/all' )
require('pry')

require_relative('./controllers/admin.rb')

get '/shanti' do
  erb(:welcome)
end
