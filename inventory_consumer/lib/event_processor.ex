defmodule EventProcessor do
  #EventProcessor variables
  @client_id :my_client2
  @topic "inventoryUpdates"
  @partition 0

  # Starts the Kafka producer
  def start_producer do
    :ok = :brod.start_producer(@client_id, @topic, [])
  end

  #Send event to Kafka topic
  def send_event(json_message) do
    :ok = :brod.produce_sync(@client_id, @topic, @partition, "", json_message)
  end

  #encode message in JSON
  def json_encode(data) do
    try do
      {:ok, Jason.encode!(data)}
    rescue
      exception -> {:error, exception.message}
    end
  end

  #decode message from JSON
  def json_decode(message) do
    Jason.decode(message)
  end
end
