# require_relative('../db/sql_runner.rb')

class Session
  attr_reader :id
  attr_accessor :event_date, :event_time, :room_id, :teacher_id, :member_id, :type_id, :status

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @event_date = options['event_date']
    @event_time = options['event_time']
    @room_id = options['room_id'].to_i
    @teacher_id = options['teacher_id'].to_i
    @member_id = options['member_id'].to_i
    @type_id = options['type_id'].to_i
    @status = options['status']
  end

end
