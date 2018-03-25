require('pg')
require_relative('../db/sql_runner')
require_relative('./customer')
require_relative('./film')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save
    sql = ("INSERT INTO tickets
    (customer_id, film_id)
    VALUES
    ($1, $2)
    RETURNING id")
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run( sql, values ).first
    @id = ticket['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete
    sql = ('DELETE FROM tickets WHERE id = $1')
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = ("UPDATE tickets SET
    customer_id = $1,
    movie_id = $2,
    WHERE id = $3")
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    ticket_hashes = SqlRunner.run(sql)
    ticket_objects = ticket_hashes.map{|ticket| Ticket.new(ticket)}
    return ticket_objects
  end

  def tickets_by_film_id()
    sql = "SELECT * FROM tickets WHERE film_id = $1"
    value = [@id]
    ticket_data = SqlRunner.run( sql, values )
    return ticket_data.map{ |ticket| Ticket.new(ticket) }
  end


end
