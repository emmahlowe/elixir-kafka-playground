defmodule EventProcessor do
  #EventProcessor variables
  @client_id :my_client
  @topic "inventory_updates"
  @partition 0

  # Starts the Kafka producer
  def start_producer do
    :ok = :brod.start_producer(@client_id, @topic, _producer_config = [])
  end

  #Send event to Kafka topic
  def send_event(json_message) do
    :ok = :brod.produce_sync(@client_id, @topic, @partition, "", json_message)
  end

  #encode message in JSON
  def json_encode(message) do
    Jason.encode!(message)
  end
end
