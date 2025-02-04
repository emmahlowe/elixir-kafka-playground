

# **Elixir, PostgreSQL and Kafka Learning Project 🚀**

This project was built **from scratch in just one week** as part of a hands-on learning experience. It was created in response to the following prompt:

> Objective
> 
> Create a simple event-driven system using Elixir, PostgreSQL, and
> Kafka. This project will simulate a basic e-commerce order processing
> system with a focus on event-driven architecture.
> 
> Project Description
> 
> You will build two services:
> 
> 1. Order Producer
> 2. Inventory Consumer
> 
> Order Producer
> 
> * Generates simulated order events
> * Stores order details in PostgreSQL
> * Publishes "OrderCreated" events to Kafka
> 
> Inventory Consumer
> 
> * Subscribes to "OrderCreated" events from Kafka
> * Updates inventory levels in PostgreSQLl
> * Publishes "InventoryUpdated" events to Kafka
> 
> Technical Requirements
> 
> 1. Use Elixir for both services
> 2. Use Ecto for database interactions
> 3. Utilize the Kafka client library for Elixir (e.g., KafkaEx)
> 4. Implement basic error handling and logging
> 5. Write unit tests for core business logic
> 6. Use Mix for project management and dependency handling
> 
> Review Criteria
> 
> 1. Code organization
> 2. Understanding of event-driven architecture
> 3. Database design and usage
> 4. Kafka integration (producing and consuming events)
> 5. Error handling and logging

## 🚀 How to Get Everything Running

**1️⃣ Start the Services**

1.  Navigate to the order_producer directory:
`cd order_producer`
2.  Start the services using Docker Compose:
`docker-compose up`
3.  Open **pgAdmin** on [localhost:9090](http://localhost:9090).
4.  Log in using the credentials found in docker-compose.yml.

**2️⃣ Seed the Database**
**🗃️ Insert Sample Data into products Table**

Run the following **TSQL script** on the products table:

`INSERT INTO products (name, description, price) VALUES
  ('Wireless Keyboard', 'Logitech Bluetooth wireless keyboard', 29.99),
  ('USB-C Hub', 'USB-C Hub description', 20),
  ('Monitor Stand', 'This adjustable wooden monitor stand can support up to 100 lbs', 45.5),
  ('Bluetooth Mouse', 'Bluetooth mouse with color-changing lights. Mousepad included.', 15.25);`

**📦 Insert Sample Data into inventory Table**
Run the following **TSQL script** on the inventory table:

`INSERT INTO inventory (product_id, quantity, inserted_at, updated_at) VALUES
(3, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);`

**3️⃣ Start the Elixir Applications**

1.  Start the **order producer**:
`cd order_producer`
`mix run --no-halt`
2.  Start the **inventory consumer**:
`cd inventory_consumer`
`mix run --no-halt`

## 🔍 How to Observe the System in Action

**Option 1: Read from the Kafka Topic**

Use the Kafka console consumer to view messages in the orders topic:
`bin/kafka-console-consumer.sh --topic orders --from-beginning --bootstrap-server localhost:9092`

**Option 2: Use UI Tools**

•  Open **pgAdmin** and inspect the database (credentials and port are in docker-compose.yml).

•  Open **UI for Apache Kafka** on the appropriate ports for a visual view of Kafka topics.


## 📝 Notes

**Auto-Creating Kafka Topics**

Rather than manually creating Kafka topics, I enabled this handy option in docker-compose.yml:

`KAFKA_AUTO_CREATE_TOPICS_ENABLE:  'true'`

If you encounter an error due to a missing topic, Kafka should retry and succeed once **auto-creation** kicks in.

## **💡 Assumptions & Design Choices**

•  One Product per Order:

I assumed an order could only have **one product** tied to it.

•  This **simplifies** the database structure.

•  If multiple products per order were required, I would have introduced a **join table** to associate orders with multiple products.

•  In a real-world app, we’d allow users to add **multiple products** to their cart and check out in a single order.

**Potential Improvements I Didn’t Get To**:

•  Adding an **Ecto seed file** for easier database setup.

•  Automating the startup of **both Elixir apps** using a **Dockerfile**.

## **📌 Entity-Relationship Diagram (ERD)**
