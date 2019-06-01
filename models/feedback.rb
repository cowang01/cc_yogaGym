# require_relative('../db/sql_runner.rb')

class Feedback
  attr_reader :id
  attr_accessor :session_id, :feedback

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @session_id = options['session_id'].to_i
    @feedback = options['feedback']
  end

  def save()
    sql = "INSERT INTO feedbacks (session_id, feedback) VALUES ($1, $2) RETURNING id;"
    values = [@session_id, @feedback]
    feedback = SqlRunner.run(sql, values)[0]
    @id = feedback['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM feedbacks;"
    SqlRunner.run(sql)
  end

  def self.remove(id)
    sql = "DELETE FROM feedbacks WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE feedbacks SET (session_id, feedback) = ($1, $2) WHERE id = $3"
    values = [@session_id, @feedback, @id]
    SqlRunner.run(sql, values)
  end

  def self.view_all()
    sql = "SELECT * FROM feedbacks"
    feedbacks = SqlRunner.run(sql)
    return feedbacks.map {|feedback| Feedback.new(feedback)}
  end

  def self.find(id)
    sql = "SELECT * FROM feedbacks WHERE id = $1"
    values = [id]
    feedback = SqlRunner.run(sql, values)[0]
    return Feedback.new(feedback)
  end

end#
