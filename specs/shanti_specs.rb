require('pry')
require_relative('../models/type.rb')
require_relative('../models/room.rb')
require_relative('../models/teacher.rb')
require_relative('../models/session.rb')
require_relative('../models/member.rb')
require_relative('../models/feedback.rb')

require('minitest/autorun')
require('minitest/rg')


class TestCustomer < MiniTest::Test
  def setup
    @type1 = Type.new({
      'id' => 1,
      'title' => 'Vinyassa Flow',
      'colour' => 'blue',
      'about' => 'A standard yoga practice'
      })
    @room1 = Room.new({
      'id' => '2',
      'title' => 'Main',
      'sized' => 15,
      'image' => '.url/image.jpeg'
      })
    @teacher1 = Teacher.new({
      'id' => '3',
      'name' => 'Susan Test',
      'bio' => 'I\'ve been testing for five months',
      'profile' => './url/image2.jpeg'
      })
    @member1 = Member.new({
      'id' => '4',
      'name' => 'David Trial',
      'join_date' => '12/05/2019',
      'waver' => 'true',
      'info' => 'Injury to left knee',
      'membership' => '15/05/2019'
      })
    @session1 = Session.new({
      'id' => '5',
      'event_date' => '24/06/2019',
      'event_time' => '18:00',
      'room_id' => 34,
      'teacher_id' => 6,
      'member_id' => '[345]',
      'type_id' => 2,
      'status' => 'open'
      })
    @feedback1 = Feedback.new({
      'id' => '6',
      'session_id' => 6789,
      'feedback' => 'It was great'
      })
  end

  def test_type_title()
    assert_equal('Vinyassa Flow', @type1.title)
  end

  def test_room_size()
    assert_equal(15, @room1.size)
  end

  def test_teacher_id()
    assert_equal(3, @teacher1.id)
  end

  def test_member_waver()
    assert_equal(true, @member1.waver)
  end

  def test_session_status()
    assert_equal('full', @session1.status)
  end

  def test_feedback_session()
    assert_equal(6789, @feedback1.session_id)
  end

  # def test_session_available()
  #   assert_equal(true, )


# further testing in seed
#mvp working.


end#
