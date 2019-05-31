# require_relative('../db/sql_runner.rb')

class Room
  attr_reader :id, :title, :size, :image

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @size = options['size'].to_i
    @image = options['image']
  end


end#
