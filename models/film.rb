require('pg')
require_relative('../db/sql_runner')
require_relative('./customer')

class Film

  attr_reader :id, :title, :price

def initialize (options)
  @id = options['id'].to_i if options['id']
  @title = options ['title']
  @price = options ['price']
end

def save
    sql = ("INSERT INTO films
    (title, price)
    VALUES
    ($1, $2)
    RETURNING id")
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql,values)
  end

  def delete
    sql = ('DELETE FROM films WHERE id = $1')
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = ("UPDATE films SET
    title = $1,
    price = $2,
    WHERE id = $3")
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    film_hashes = SqlRunner.run(sql)
    film_objects = film_hashes.map{|film|
    Film.new(film)}
    return film_objects
  end

  def show_films
    sql = "SELECT films*
    FROM Films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE film_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = films.map{ |film| Film.new(film) }
    return result
  end







end
