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
  @rooms = Room.view_all()
  @types = Type.view_all()
  @teacher = Teacher.find(params[:id])
  erb(:'admin/new_session')
end

get '/gym/ad-view/:id' do
  binding.pry
  @teacher = Teacher.find(params[:id])
  @sessions = @teacher.sessions()
  erb(:'admin/teacher')
end

post '/gym/ad-new/:id' do
  new_class = Session.new({
    'event_date' => params[:event_date],
    'event_time' => params[:event_time],
    'room_id' => params[:room_id],
    'teacher_id' => params[:id],
    'member_id' => "[]",
    'type_id' => params[:type],
    'status' => params[:status]
    })
    # binding.pry
    new_class.save()
    redirect(:'admin/menu')
  end

  get '/gym/ad-push/:id' do
    @session = Session.find(params[:id])
    erb(:'admin/push')
  end

  post '/gym/ad-push/:id' do
    @session = Session.find(params[:id])
    @teacher = Teacher.find(@session.teacher_id)
    @teacher.push_book(params[:member_id].to_i, params[:id])
    redirect('/gym/ad-view/#{@teacher.id}')
  end
