require_relative('../db/sql_runner.rb')

class Type
  attr_reader :id
  attr_accessor :title, :about, :colour

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @colour = options['colour']
    @about = options['about']
  end

  def save()
    sql = "INSERT INTO types (title, colour, about) VALUES ($1, $2, $3) RETURNING id;"
    values = [@title, @colour, @about]
    type = SqlRunner.run(sql, values)[0]
    @id = type['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM types;"
    SqlRunner.run(sql)
  end

  def self.remove(id)
    sql = "DELETE FROM types WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE types SET (title, colour, about) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @colour, @about, @id]
    SqlRunner.run(sql, values)
  end

  def self.view_all()
    sql = "SELECT * FROM types"
    types = SqlRunner.run(sql)
    return types.map {|type| Type.new(type)}
  end

  def self.find(id)
    sql = "SELECT * FROM types WHERE id = $1"
    values = [id]
    type = SqlRunner.run(sql, values)[0]
    return Type.new(type)
  end


end#
