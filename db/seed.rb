require_relative('../models/type.rb')
require_relative('../models/room.rb')
require_relative('../models/teacher.rb')
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/feedback.rb')

require('pry')

Feedback.delete_all()
Session.delete_all()
Member.delete_all()
Teacher.delete_all()
Room.delete_all()
Type.delete_all()


type1 = Type.new({
  'title' => 'Vinyasa Flow',
  'colour' => 'cyan',
  'about' => 'Vinyassa Flow involves synchronising the breath with a series of postures. The body is kept moving in line with the breath, a process which creates internal heat, purifying and detoxifying sweat, which leads to improved circulation, increased concentration, lasting focus and a more supple, strong and toned body.'
  })
type1.save()

room1 = Room.new({
  'title' => 'Ganesh Studio',
  'size' => '18',
  'image' => '../public/placeholder.jpeg'
  })
room1.save()

teacher1 = Teacher.new({
  'name' => 'Sasha Harper',
  'bio' => 'Sasha (RYT500) is a yogini, world traveller and the founder of Shanti Yoga Glasgow.
  Sasha has over 900 hours Yoga training with global teachers & is a Yoga Alliance Professionals UK Senior Yoga Teacher and her Teacher Trainings are fully Yoga Alliance Professionals certified.',
  'profile' => '../public/placeholder.jpeg'
  })
teacher1.save()

member1 = Member.new({
  'name' => 'Graham Cowan',
  'join_date' => Date.strptime('2018-30-04', "%Y-%d-%m"),
  'waver' => 'true',
  'info' => 'Looking to work on hip openers',
  'membership' => Date.strptime('2019-20-06', "%Y-%d-%m"),
  'membership_vol'=> 0
  })
# binding.pry
member1.save()

session1 = Session.new({
  'event_date' => Date.strptime('05/06/2019', "%d/%m/%Y").strftime("%Y-%m-%d"),
  'event_time' => '18:00',
  'room_id' => room1.id,
  'teacher_id' => teacher1.id,
  'member_id' => '[]',
  'type_id' => type1.id,
  'status' => 'open'
  })
session1.save()
# Date.strptime(options['event_date'], "%d/%m/%Y").strftime("%Y-%m-%d")

feedback1 = Feedback.new({
  'session_id' => session1.id,
  'feedback' => 'Hello, can you possibly send me this sequence to try at home?'
  })
feedback1.save()

# type1.colour = 'green'
# type1.update()
# room1.image = './url/no_image.gif'
# room1.update()
# teacher1.name = 'Cat Glasgow'
# teacher1.update()
# member1.join_date = '2018-03-04'
# member1.update()
# session1.event_time = '18:30'
# session1.update()
# feedback1.feedback = ''
# feedback1.update()


test2 = member1.add_membership
# test =
binding.pry
nil
