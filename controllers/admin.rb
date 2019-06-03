require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/type.rb')
require_relative('../models/room.rb')
require_relative('../models/teacher.rb')
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/feedback.rb')


get "/gym/admin" do
  erb(:'admin/log_in')
end

get "/gym/ad-menu" do
  if Teacher.find(params['id'].to_i).id > 0
    @teacher = Teacher.find(params['id'].to_i)
    erb(:'admin/menu')
  else
    erb(:welcome) #change to errror screen
  end
end

get "/gym/ad-schedule/:id" do
  @sessions = Session.view_all()
  @teacher = Teacher.find(params[:id])
  #check getdate
  erb(:'admin/schedule')
end

get "/gym/ad-create/:id" do
  @rooms = Room.view_all()
  @types = Type.view_all()
  @teacher = Teacher.find(params[:id])
  erb(:'admin/new_session')
end

get "/gym/ad-view/:id" do
  @teacher = Teacher.find(params[:id])
  @sessions = @teacher.sessions()
  erb(:'admin/teacher')
end

post "/gym/ad-new/:id" do
  @teacher = Teacher.find(params[:id])
  sessions = Session.view_all()
  check = false
  for session in sessions
    #problem with date format
    if session.event_date == params['event_date'] && session.event_time == params['event_time'] && session.room_id == params['room_id']
      check = true
    end
  end
  if check == false
  new_class = Session.new({
    'event_date' => params['event_date'],
    'event_time' => params['event_time'],
    'room_id' => params['room_id'],
    'teacher_id' => params[:id],
    'member_id' => "0",
    'type_id' => params['type'],
    'status' => params['status']
    })
    new_class.save()
    redirect("/gym/ad-schedule/#{@teacher.id}")
  else
    redirect("/gym/exists/#{@teacher.id}")
  end
  end

  get "/gym/exists/:id" do
    @teacher = Teacher.find(params[:id])
    erb(:'admin/exists')
  end

  get "/gym/ad-push/:id" do
    @session = Session.find(params[:id])
    @room = @session.room()
    @type = @session.type()
    binding.pry
    erb(:'admin/push')
  end

  post "/gym/ad-push/:id" do
    @session = Session.find(params[:id])
    @teacher = Teacher.find(@session.teacher_id)
    @teacher.push_book(params[:member_id].to_i, params[:id])
    redirect("/gym/ad-view/#{@teacher.id}")
  end

  get "/gym/ad-details/:id" do
    @session = Session.find(params[:id])
    @members = @session.member()
    @room = @session.room()
    @type = @session.type()
    erb(:'admin/details')
  end

  get "/gym/ad-member/:id" do
    @session = Session.find(params['session_id'])
    @member = Member.find(params[:id])
    erb(:'admin/update_member')
  end

  post "/gym/ad-member/:id" do
    member = Member.find(params['member_id'])
    member.name = params['name']
    member.info = params['info']
    member.membership = params['membership']
    member.membership_vol = params['membership_vol']
    member.update()
    redirect("/gym/ad-details/#{params[:id]}")
  end

  get "/gym/ad-close/:id" do
    @session = Session.find(params[:id])
    erb(:'admin/delete_class')
    #close class message?
  end

  post "/gym/ad-delete/:id" do
    @session = Session.find(params[:id])
    teacher = @session.teacher_id
    members = @session.member()
    for member in members
      member.membership_vol += 1
      member.membership = Time.now() + 7
      member.update()
    end
    Session.remove(@session.id)
    redirect("/gym/ad-view/#{teacher}")
  end

  get "/gym/ad-delete_member/:id" do
    @session = Session.find(params['session_id'])
    @member = Member.find(params[:id])
    @member.membership_vol += 1
    @member.membership = Time.now + 7
    @member.update()
    @session.member_id.delete(params[:id])
    @session.update()
    redirect("/gym/ad-details/#{@session.id}")
  end
