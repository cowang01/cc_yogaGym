require_relative('../db/sql_runner.rb')

class Teacher
  attr_reader :id
  attr_accessor :name, :bio, :profile

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bio = options['bio']
    @profile = options['profile']
  end

  def save()
    sql = "INSERT INTO teachers (name, bio, profile) VALUES ($1, $2, $3) RETURNING id;"
    values = [@name, @bio, @profile]
    teacher = SqlRunner.run(sql, values)[0]
    @id = teacher['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM teachers;"
    SqlRunner.run(sql)
  end

  def self.remove(id)
    sql = "DELETE FROM teachers WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE teachers SET (name, bio, profile) = ($1, $2, $3) WHERE id = $4"
    values = [@name, @bio, @profile, @id]
    SqlRunner.run(sql, values)
  end

  def self.view_all()
    sql = "SELECT * FROM teachers"
    teachers = SqlRunner.run(sql)
    return teachers.map {|teacher| Teacher.new(teacher)}
  end

  def self.find(id)
    sql = "SELECT * FROM teachers WHERE id = $1"
    values = [id]
    teacher = SqlRunner.run(sql, values)[0]
    return Teacher.new(teacher)
  end

  def push_book(member_id, session_id)
    sql = "SELECT * FROM sessions WHERE id = $1"
    values = [session_id]
    session = SqlRunner.run(sql, values)[0]
    push_session = Session.new(session)
    members = push_session.member_id.split(',').map { |id| id.to_i }
    push_session.member_id = members.push(member_id)
    push_session.available()
    push_session.update()
  end

  def sessions()
    sql = "SELECT * FROM sessions WHERE teacher_id = $1 AND event_date >= NOW()"
    values = [@id]
    sessions = SqlRunner.run(sql, values)
    return sessions.map{ |session| Session.new(session) }
  end

  def self.find_id(name)
    sql = "SELECT * FROM teachers WHERE name = $1"
    values = [name]
    teacher = SqlRunner.run(sql, values)[0]
    return teacher
  end

end#
