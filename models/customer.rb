require('pg')
require_relative('../db/sql_runner')
require_relative('./film')

class Customer

  attr_reader :id, :name, :wallet

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @name = options ['name']
    @wallet = options ['wallet']
  end

  def save
    sql = ("INSERT INTO customers
    (name, wallet)
    VALUES
    ($1, $2)
    RETURNING id")
    values = [@name, @wallet]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end


  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete
    sql = ('DELETE FROM customers WHERE id = $1')
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = ("UPDATE customers SET
      name = $1,
      wallet = $2,
      WHERE id = $3")
      values = [@name, @wallet, @id]
      SqlRunner.run(sql, values)
    end

    def self.all()
      sql = "SELECT * FROM customers"
      customer_hashes = SqlRunner.run(sql)
      customer_objects = customer_hashes.map{|person|
      Customer.new(person)}
      return customer_objects
    end

    def show_customers
    sql = "SELECT customers.*
      FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE film_id = $1"
    values = [@id]
    stars = SqlRunner.run( sql, values )
    result = customers.map{ |customer| Customer.new(customer) }
    return result
  end




end
