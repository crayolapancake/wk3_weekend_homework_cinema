DROP TABLE tickets;
DROP TABLE films;
DROP TABLE customers;


CREATE TABLE customers (
 ID SERIAL8 PRIMARY KEY,
 name VARCHAR(255),
 wallet INT8
);

CREATE TABLE films (
 ID SERIAL8 PRIMARY KEY,
 title VARCHAR(255),
 price INT8
);

CREATE TABLE tickets (
 ID SERIAL8 PRIMARY KEY,
 customer_id INT8 REFERENCES customers(id) ON DELETE CASCADE,
 film_id INT8 REFERENCES films(id) ON DELETE CASCADE
-- fee here!?
);
