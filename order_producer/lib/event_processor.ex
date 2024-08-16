defmodule EventProcessor do
  #EventProcessor variables
  @client_id :my_client
  @topic "orders"
  @partition 0

  # Starts the Kafka producer
  def start_producer do
    case :brod.start_producer(:my_client, "orders", []) do
      :ok ->
        :ok
      {:error, reason} ->
        Logger.error("Failed to start Kafka producer: #{inspect(reason)}")
        {:error, reason}
    end
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
