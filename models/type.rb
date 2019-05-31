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


end#
