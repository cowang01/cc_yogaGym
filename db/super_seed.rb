require_relative('../models/type.rb')
require_relative('../models/room.rb')
require_relative('../models/teacher.rb')
require_relative('../models/member.rb')
require_relative('../models/session.rb')
require_relative('../models/feedback.rb')

type2 = Type.new({
  'title' => 'Prana Flow Yoga',
  'colour' => 'orange',
  'about' => 'Prana Vinyasa Yoga is an energetic, creative, full-spectrum approach to embodying the flow of yoga cultivated by Shiva Rea. Classes follow three levels: Level 2 Solar Prana Vinyasa Flow. L1-2 Lunar Prana Vinyasa Flow (Yin Yang) and the most restorative prana flow practice which is Soma (Level 1).'
  })
type2.save()

room2 = Room.new({
  'title' => 'White Studio',
  'sized' => '12',
  'image' => '../public/placeholder2.jpeg'
  })
room2.save()

teacher2 = Teacher.new({
  'name' => 'Zeus Light',
  'bio' => 'Zeus (RYT500) is a yogini, world traveller and the founder of Shanti Yoga Glasgow.
  Zeus has over 900 hours Yoga training with global teachers & is a Yoga Alliance Professionals UK Senior Yoga Teacher and her Teacher Trainings are fully Yoga Alliance Professionals certified.',
  'profile' => '../public/placeholder.jpeg'
  })
teacher2.save()



type3 = Type.new({
  'title' => 'Yin Yoga',
  'colour' => 'red',
  'about' => 'A slower, more deeper style of yoga which focuses on holding postures for longer, with the aim of increasing circulation in the joints and improving flexibility. Yin is a slower paced yoga and poses are held for longer, it allows the practitioner to turn their focus inwards, creating balance, harmony and peace in the mind.'
  })
type3.save()


room3 = Room.new({
  'title' => 'Massage Therapy',
  'sized' => '1',
  'image' => '../public/placeholder.jpeg'
  })
room3.save()

teacher3 = Teacher.new({
  'name' => 'Hestia',
  'bio' => 'Hestia (RYT500) is a yogini, world traveller and the founder of Shanti Yoga Glasgow.
  Hestia has over 900 hours Yoga training with global teachers & is a Yoga Alliance Professionals UK Senior Yoga Teacher and her Teacher Trainings are fully Yoga Alliance Professionals certified.',
  'profile' => '../public/placeholder.jpeg'
  })
teacher3.save()



type4 = Type.new({
  'title' => 'Thai Massage',
  'colour' => 'white',
  'about' => 'Traditional Thai Yoga massage is a dynamic healing art involving massage techniques, pressing, stretching, and passive manipulations that resemble the asana stretches of yoga. It is a truly rewarding experience which leaves you more supple, relaxed & in balance. The receiver wears loose clothing. Thai Massage is on a Thai futon mattress on the floor, pillows & bolsters are also used for your comfort.'
  })
type4.save()


teacher4 = Teacher.new({
  'name' => 'Ares',
  'bio' => 'Ares (RYT500) is a yogini, world traveller and the founder of Shanti Yoga Glasgow.
  Ares has over 900 hours Yoga training with global teachers & is a Yoga Alliance Professionals UK Senior Yoga Teacher and her Teacher Trainings are fully Yoga Alliance Professionals certified.',
  'profile' => '../public/placeholder.jpeg'
  })
teacher4.save()

type5 = Type.new({
  'title' => 'Forrest Yoga',
  'colour' => 'black',
  'about' => 'Forrest Yoga is a modern style of yoga that focuses on breath, strength, integrity and spirit. It works very attentively with body awareness, breath work and intelligent sequencing of asanas. Forrest Yoga encourages the students to build a strong practice that gives you what you need today- maybe a soothing breath or a sweaty sun salutation! Forrest Yoga doesn\'t flow as fast as Vinyasa Flow and is focussed more on holding poses.'
  })
type5.save()
