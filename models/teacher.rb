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
    room = SqlRunner.run(sql, values)[0]
    @id = room['id'].to_i
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

end#
