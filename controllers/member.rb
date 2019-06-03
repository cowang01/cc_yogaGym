require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/type.rb')
require_relative('../models/room.rb')
require_relative('../models/teacher.rb')
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/feedback.rb')


  get "/gym/new_member" do
    erb(:'member/new_member')
  end

  post "/gym/new-member" do
    @new_member = Member.new({
      'name' => params['name'],
      'join_date' => Time.now(),
      'waver' => params['waver'],
      'info' => params['info'],
      'membership' => Time.now(),
      'membership_vol' => 0
        })
    @new_member.save()
    redirect("/gym/new-member/#{@new_member.id}")
  end

  get "/gym/new-member/:id" do
    @id = params[:id]
    erb(:'member/new_confirmation')
  end

  get "/gym/mem-menu" do
    members = Member.view_all()
    check = false
    for member in members
      if member.id == params['id'].to_i
        check = true
      end
    end
    if check == false
      redirect("/gym/mem-incorrect")
    else
      redirect("/gym/mem-menu/#{params['id']}")
    end
    #add name functionality
  end

  get "/gym/mem-incorrect" do
    erb(:'member/incorrect')
  end

  get "/gym/mem-menu/:id" do
    @member = Member.find(params[:id])
    erb(:'member/mem-menu')
  end

  get "/gym/mem-schedule/:id" do
    @sessions = Session.view_all()
    @member = Member.find(params[:id])
    erb(:'member/schedule')
  end

  get "/gym/mem-edit/:id" do
    @member = Member.find(params[:id])
    erb(:'member/edit_details')
  end

  post "/gym/mem-update/:id" do
    @member = Member.find(params[:id])
    @member.name = params['name']
    @member.info = params['info']
    @member.update()
    redirect("/gym/mem-menu/#{@member.id}")
  end

  get "/gym/membership/:id" do
    @member = Member.find(params[:id])
    erb(:'member/membership')
  end

  post "/gym/membership/:id" do
    @member = Member.find(params[:id])
    membership_vol = params['membership_vol'].to_i
    case membership_vol
    when 1
      @member.membership_vol += 1
      @member.membership = Time.now + 7
    when 2
      @member.membership_vol += 2
      @member.membership = Time.now + 7
    when 10
      @member.membership_vol += 10
      @member.membership = Time.now + 30
    else
    end
    @member.update()
    erb(:'member/charged')
  end

  get "/gym/mem-book/:id" do
    @member = Member.find(params[:id])
    @session = Session.find(params['session_id'])
    if @member.membership_vol > 0 && @member.membership > Time.now - 1
      @session.member_id.push(@member.id)
      @member.membership_vol -= 1
      @session.update()
      @member.update()
      erb(:'member/book_confirmed')
    else
    erb(:'member/book_unable')
    end  
  end
