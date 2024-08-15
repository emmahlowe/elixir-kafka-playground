Welcome to my BE HW project. This is my README.


1. Run docker-compose up
2. cd into order_producer run mix run --no-halt
3. cd into order_producer run mix run --no-halt

To see things moving:

Read from topic: 
bin/kafka-console-consumer.sh --topic orders --from-beginning --bootstrap-server localhost:9092

OR open up pgAdmin and UI for Apache Kafka on the approriate ports

