require_relative('../db/sql_runner.rb')

class Session
  attr_reader :id
  attr_accessor :event_date, :event_time, :room_id, :teacher_id, :member_id, :type_id, :status

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @event_date = Date.strptime(options['event_date'], "%d/%m/%Y").strftime("%Y-%m-%d")
    @event_time = options['event_time']
    @room_id = options['room_id'].to_i
    @teacher_id = options['teacher_id'].to_i
    @member_id = options['member_id'].to_i
    @type_id = options['type_id'].to_i
    @status = options['status']
  end

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

end#
