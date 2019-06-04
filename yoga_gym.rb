require( 'sinatra' )
require( 'sinatra/contrib/all' )
also_reload('./*')

require('pry')

require_relative('./controllers/admin.rb')
require_relative('./controllers/member.rb')

get '/gym' do
  erb(:welcome)
end

get '/gym/log_in' do
  @members = Member.view_all()
  erb(:log_in)
end

get "/gym/map" do
  erb(:map)
end
