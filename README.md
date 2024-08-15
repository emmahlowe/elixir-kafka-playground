Welcome to my BE HW project. This is my README.

How to get everything running
  Note: Sorry it's kinda a lot, I didn't set up a way to auto seed the db and didn't look into spinning up my elixir producer/consumer with docker-compose 
1. cd into order_producer and run "docker-compose up"
2. Open up pgAdmin on [port](http://127.0.0.1:9090/)
3. Log in using the credentials in docker-compose.yml
4. Run this TSQL script on the products table 
   INSERT INTO products (name, description, price) VALUES
  ('Wireless Keyboard', 'Logitech bluetooth wireless keyboard', 29.99),
  ('USB-C Hub', 'USB-C Hub description', 20),
  ('Monitor Stand', 'This adjustable wooden monitor stand can support up to 100 lbs', 45.5),
  ('Bluetooth Mouse', 'Bluetooth mouse with color changing lights. Mousepad is included.', 15.25);
5. Run this TSQL script on the inventory table
   INSERT INTO inventory (product_id, quantity, inserted_at, updated_at) VALUES
  (3, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
7. cd into order_producer and run "mix run --no-halt"
8. cd into inventory_consumer and run "mix run --no-halt"

To see things moving:

Read from topic: 
bin/kafka-console-consumer.sh --topic orders --from-beginning --bootstrap-server localhost:9092

OR open up pgAdmin (credentials and port in docker-compose.yml) and UI for Apache Kafka on the approriate ports

