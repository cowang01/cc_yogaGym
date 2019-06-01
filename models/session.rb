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
    @member_id = options['member_id'].split().map { |id| id.to_i }
    @type_id = options['type_id'].to_i
    @status = options['status']
  end
  # .reject {|element| element == '[' || element == ']' }.map {|id| id}

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
    sql = "UPDATE sessions SET (event_date, event_time, room_id, teacher_id, member_id, type_id, status) = ($1, $2, $3, $4, $5, $6, $7) WHERE id = $8"
    values = [@event_date, @event_time, @room_id, @teacher_id, @member_id, @type_id, @status, @id]
    SqlRunner.run(sql, values)
  end

  def self.view_all()
    sql = "SELECT * FROM sessions"
    sessions = SqlRunner.run(sql)
    return sessions.map {|session| Session.new(session)}
  end

  def self.find(id)
    sql = "SELECT * FROM sessions WHERE id = $1"
    values = [id]
    session = SqlRunner.run(sql, values)[0]
    return Session.new(session)
  end

  def available()
    sql = "SELECT * FROM rooms WHERE id = $1"
    values = [@room_id]
    size = SqlRunner.run(sql, values)[0].size.to_i
    if size <= @member_id.count()
      return false
      @status = 'full'
      update()
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

end#
