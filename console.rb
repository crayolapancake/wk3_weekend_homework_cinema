require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')
require('pry-byebug')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()


customer1 = Customer.new({'name' => 'Jemma',
  'wallet' => '20'})
customer1.save

customer2 = Customer.new({'name' => 'Tori',
  'wallet' => '50'})
customer2.save

film1 = Film.new({'title' => 'Insidious, The Last Key',
  'price' => '12'})
film1.save

film2 = Film.new({'title' => 'Lego Movie 3D',
  'price' => '14'})
film2.save

ticket1 = Ticket.new({'customer_id' => customer1.id,
  'film_id' => film1.id})
  #  'price' => 12
  ticket1.save
