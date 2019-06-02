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

get '/gym/admenu' do
  @teacher = Teacher.find(params['id'].to_i)
  erb(:'admin/menu')
end
