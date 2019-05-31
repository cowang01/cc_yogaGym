require_relative('../db/sql_runner.rb')
require 'Date'

class Member
  attr_reader :id
  attr_accessor :name, :join_date, :waver, :info, :membership

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @join_date =  Date.strptime(options['join_date'], "%d/%m/%Y").strftime("%Y-%m-%d")
    @waver = options['waver'] == 'true'
    @info = options['info']
    @membership = Date.strptime(options['membership'], "%d/%m/%Y").strftime("%Y-%m-%d")
  end

  def save()
    sql = "INSERT INTO members (name, join_date, waver, info, membership) VALUES ($1, $2, $3, $4, $5) RETURNING id;"
    values = [@name, @join_date, @waver, @info, @membership]
    room = SqlRunner.run(sql, values)[0]
    @id = room['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM members;"
    SqlRunner.run(sql)
  end

  def self.remove(id)
    sql = "DELETE FROM members WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end


end#
