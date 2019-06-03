require_relative('../db/sql_runner.rb')

class Session
  attr_reader :id
  attr_accessor :event_date, :event_time, :room_id, :teacher_id, :member_id, :type_id, :status

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @event_date = options['event_date']
    @event_time = options['event_time']
    @room_id = options['room_id'].to_i
    @teacher_id = options['teacher_id'].to_i
    @member_id = options['member_id']
    @type_id = options['type_id'].to_i
    @status = options['status']
  end
  #.reject {|element| element == '[' || element == ']' }.map {|id| id}
  # .split()
  # options['member_id'].split(',').map { |id| id.to_i }

  def save()
    sql = "INSERT INTO sessions (event_date, event_time, room_id, teacher_id, member_id, type_id, status) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id;"
    values = [@event_date, @event_time, @room_id, @teacher_id, @member_id, @type_id, @status]
    session = SqlRunner.run(sql, values)[0]
    @id = session['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM sessions;"
    SqlRunner.run(sql)
  end

  def self.remove(id)
    sql = "DELETE FROM sessions WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def update()
    # @member_id .split(',').map { |id| id.to_i }
    sql = "UPDATE sessions SET (event_date, event_time, room_id, teacher_id, member_id, type_id, status) = ($1, $2, $3, $4, $5, $6, $7) WHERE id = $8"
    values = [@event_date, @event_time, @room_id, @teacher_id, @member_id, @type_id, @status, @id]
    run = SqlRunner.run(sql, values)
  end

  def self.view_all()
    sql = "SELECT * FROM sessions WHERE event_date >= NOW()"
    sessions = SqlRunner.run(sql)
    return sessions.map {|session| Session.new(session)}
  end

  def self.find(id)
    sql = "SELECT * FROM sessions WHERE id = $1"
    values = [id]
    session = SqlRunner.run(sql, values)[0]
    session_find = Session.new(session)
    session_format = session_find.member_id.split(',').map{|id| id.to_i}
    session_find.member_id = session_format
    session_find.member_id.delete(0)
    return session_find
  end

  def available()
    sql = "SELECT * FROM rooms WHERE id = $1"
    values = [@room_id]
    rooms = SqlRunner.run(sql, values)[0]
    room = Room.new(rooms)
    if room.sized <= @member_id.count()
      @status = 'full'
      update()
      return false
    else
      return true
    end
  end

  def book(member_id)
    message = nil
    if available() == true
      @member_id.push(member_id)
      update()
      message = true
    else
      message = false
    end
    @member_id.delete(0)
    return message
  end

  def cancel_book(member_id)
    @member_id.delete(member_id)
    return "booking cancelled"
  end

  def member_check(member_id)
    sql = "SELECT * FROM members WHERE id = $1"
    values = [member_id]
    member = SqlRunner.run(sql, values)[0]
    membership = Member.new(member).membership
    mem_vol = Member.new(member).membership_vol
    if membership >= @event_date && mem_vol > 0
      return true
    else
      return false
    end
  end

  def type()
    sql = "SELECT * FROM types WHERE id = $1"
    values = [@type_id]
    type = SqlRunner.run(sql, values)[0]
    return Type.new(type)
  end

  def room()
    sql = "SELECT * FROM rooms WHERE id = $1"
    values = [@room_id]
    room = SqlRunner.run(sql, values)[0]
    return Room.new(room)
  end

  def member()
    all_members = []
    for member in @member_id
      sql = "SELECT * FROM members WHERE id = $1"
      values = [member]
      db_member = SqlRunner.run(sql, values)[0]
      new_member = Member.new(db_member)
      all_members.push(new_member)
    end
    return all_members
  end

end#
