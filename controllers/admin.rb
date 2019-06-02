require( 'sinatra' )
require( 'sinatra/contrib/all' )
require('pry')

require_relative('../models/type.rb')
require_relative('../models/room.rb')
require_relative('../models/teacher.rb')
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/feedback.rb')


get '/gym/admin' do
  erb(:'admin/log_in')
end

get '/gym/ad-menu' do
  if Teacher.find(params['id'].to_i).id > 0
    @teacher = Teacher.find(params['id'].to_i)
    erb(:'admin/menu')
  else
    erb(:welcome)
  end
  end

get '/gym/ad-schedule/:id' do
  @sessions = Session.view_all()
  @teacher = Teacher.find(params[:id])
  #check getdate
  erb(:'admin/schedule')
end

get '/gym/ad-create/:id' do
  @teacher = Teacher.find(params[:id])
  erb(:'admin/new_session')

end

get '/gym/ad-view/:id' do

end
