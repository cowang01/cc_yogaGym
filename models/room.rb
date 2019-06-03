require_relative('../db/sql_runner.rb')

class Room
  attr_reader :id, :title, :sized
  attr_accessor :image

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @sized = options['sized'].to_i
    @image = options['image']
  end

  def save()
    sql = "INSERT INTO rooms (title, sized, image) VALUES ($1, $2, $3) RETURNING id;"
    values = [@title, @sized, @image]
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

  def update()
    sql = "UPDATE rooms SET (title, sized, image) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @sized, @image, @id]
    SqlRunner.run(sql, values)
  end

  def self.view_all()
    sql = "SELECT * FROM rooms"
    rooms = SqlRunner.run(sql)
    return rooms.map {|room| Room.new(room)}
  end

  def self.find(id)
    sql = "SELECT * FROM rooms WHERE id = $1"
    values = [id]
    room = SqlRunner.run(sql, values)[0]
    return Room.new(room)
  end

end#
