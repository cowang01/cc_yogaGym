# require_relative('../db/sql_runner.rb')

class Feedback
  attr_reader :id
  attr_accessor :session_id, :feedback

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @session_id = options['session_id'].to_i
    @feedback = options['feedback']
  end
end#
