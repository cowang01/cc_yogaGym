require_relative('../db/sql_runner.rb')
require 'Date'

class Member
  attr_reader :id
  attr_accessor :name, :join_date, :waver, :info, :membership, :membership_vol

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @join_date = options['join_date']
    @waver = options['waver'] == 'true'
    @info = options['info']
    @membership = options['membership']
    @membership_vol = options['membership_vol'].to_i
  end
  # Date.strptime( , "%Y-%d-%m")

  def save()
    sql = "INSERT INTO members (name, join_date, waver, info, membership, membership_vol) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id;"
    values = [@name, @join_date, @waver, @info, @membership, @membership_vol]
    member = SqlRunner.run(sql, values)[0]
    @id = member['id'].to_i
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

  def update()
    sql = "UPDATE members SET (name, join_date, waver, info, membership, membership_vol) = ($1, $2, $3, $4, $5, $6) WHERE id = $7"
    values = [@name, @join_date, @waver, @info, @membership, @membership_vol, @id]
    SqlRunner.run(sql, values)
  end

  def self.view_all()
    sql = "SELECT * FROM members"
    members = SqlRunner.run(sql)
    return members.map {|member| Member.new(member)}
  end

  def self.find(id)
    sql = "SELECT * FROM members WHERE id = $1"
    values = [id]
    member = SqlRunner.run(sql, values)[0]
    return Member.new(member)
  end

  def sign_waver()
    @waver = true
    update()
  end

  def add_basic_membership()
    @membership = Date.today + 7
    @membership_vol += 1
  end



end#
