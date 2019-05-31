# require_relative('../db/sql_runner.rb')

class Member
  attr_reader :id
  attr_accessor :name, :join_date, :waver, :info, :membership

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @join_date = options['join_date']
    @waver = options['waver'] == 'true'
    @info = options['info']
    @membership = options['membership']
  end


end#
