**Welcome to my BE HW project. This is my README.**

**How to get everything running**
  
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

**To see things moving:**

Read from topic: 
bin/kafka-console-consumer.sh --topic orders --from-beginning --bootstrap-server localhost:9092

OR open up pgAdmin (credentials and port in docker-compose.yml) and UI for Apache Kafka on the approriate ports

**Notes:**
Rather than auto create kafka topics I found this handy option "KAFKA_AUTO_CREATE_TOPICS_ENABLE: 'true'" so if you hit a message that a topic isn't created then it should try again and succeed the second time after the auto create takes care of business

**Assumptions made and rambles:**
I assumed that an order could only have one product tied to it. See ERD below for inventory, order, product relationships. 
![image](https://github.com/user-attachments/assets/97cfcdbd-3f93-44bc-bf4c-c46820c21576)

Separate Elixir apps: Separation of concerns and fault tolerance  if the inventory update system fails at least the order system can still be running

One product per order: Made things simpler db wise if we had multiple products per order then I would have wanted to add another table to link products to orders and that would have added another layer of complexity to db interactions that I didn't want to deal with. IRL yes, we would want an app that allows customers to add multiple products to their cart and checkout in one order. 

Logging: Right now errors and logging are just outputted to the terminal, given more time and if this was a real app I would have wanted to have an Kafka topic to send errors too and then another microservice to do something with the errors. For this I focused on an approach that made it so an error wouldn’t take down a microservice or clog up the pipe. 

Error handling: I opted to do error handling in the core business logic functions rather than service functions that were made for db/kafka interactions. I did this so there was a standard tuple {:ok, data} or {:error, message} response from service functions and so that in the core business logic I could easily break out if there was an error. 

Migrations: Migrations would be handled by just the order_producer app and not the inventory_consumer app. 

Code structure: I tried to split out working with the db and kafka server into service functions in separate files to isolate functionality.  

I would have liked to add a db seed file to ecto and figure that out as well as spin up both elixir apps from a docker file but didn't get to it. 

Testing: I read through Mox's docks, installed it and got a basic test working in the inventory_consumer. Then I moved onto reorganizing code, getting the last inventory updates piece working and didn't go back and update my tests so I believe any that were working are broken. I have a question for you around how I could have better structured my code to make it more easily testable so I don't have to mock so many function calls. I couldn’t think of a better way to flow through the business logic and split things out into appropriate functions. If I have more time next week I might work on getting my tests up and running just for more practice with Mox since it seems like we will be using that in our new codebase. 
![image](https://github.com/user-attachments/assets/3513e3bf-f7fb-409b-9a99-303f3c2c3f90)



