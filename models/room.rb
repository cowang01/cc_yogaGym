require_relative('../db/sql_runner.rb')

class Room
  attr_reader :id, :title, :size, :image

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @size = options['size'].to_i
    @image = options['image']
  end

  def save()
    sql = "INSERT INTO rooms (title, size, image) VALUES ($1, $2, $3) RETURNING id;"
    values = [@title, @size, @image]
    room = SqlRunner.run(sql, values)[0]
    @id = room['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM rooms;"
    SqlRunner.run(sql)
  end

  def self.remove(id)
    sql = "DELETE FROM rooms WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

end#
