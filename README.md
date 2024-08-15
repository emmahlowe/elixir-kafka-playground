Welcome to my BE HW project. This is my README.


1. Run docker-compose up
2. run mix run --no-halt
3. 

Write to topic: 
bin/kafka-console-producer.sh --topic test1 --bootstrap-server localhost:9092

Read from topic: 
bin/kafka-console-consumer.sh --topic test1 --from-beginning --bootstrap-server localhost:9092

