# require_relative('../db/sql_runner.rb')

class Type
  attr_reader :id
  attr_accessor :title, :about

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @about = options['about']
  end


end#
