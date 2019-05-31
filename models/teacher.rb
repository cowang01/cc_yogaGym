# require_relative('../db/sql_runner.rb')

class Teacher
  attr_reader :id
  attr_accessor :name, :bio, :profile

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bio = options['bio']
    @profile = options['profile']
  end

end#
