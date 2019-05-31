require_relative('../models/type.rb')
require_relative('../models/room.rb')
require_relative('../models/teacher.rb')
require_relative('../models/member.rb')

require('pry')

Type.delete_all()
Room.delete_all()
Teacher.delete_all()
Member.delete_all()

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
  'join_date' => '01/04/2018',
  'waver' => 'true',
  'info' => 'Looking to work on hip openers',
  'membership' => '20/05/2019'
  })
# binding.pry
member1.save()
