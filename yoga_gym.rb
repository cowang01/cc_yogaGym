require( 'sinatra' )
require( 'sinatra/contrib/all' )
also_reload('./*')
require('pry')

require_relative('./controllers/admin.rb')

get '/gym' do
  erb(:welcome)
end

get '/gym/log_in' do
  erb(:log_in)
end
