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
