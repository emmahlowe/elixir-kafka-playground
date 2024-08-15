defmodule OrderProducer do
  @moduledoc """
  The purpose of this order producer is to:

  * Generates simulated order events
  * Stores order details in PostgreSQL
  * Publishes "OrderCreated" events to Kafka


  This process is kicked off when the application starts and continues every 15 seconds as long as the application is running
  """

  def send_message() do
    with :ok <- EventProcessor.start_producer(),
        #generate simulated order event
         order <- OrderSimulator.generate_order(),
         #stores simulated order event in db
         {:ok, _order_struct} <- DbService.store_order(order),
         #encode message
         json_message <- EventProcessor.json_encode(order),
         #publishes event to Kafka
         :ok <- EventProcessor.send_event(json_message) do
      {:ok, json_message}
    else
      :error ->
        IO.puts("Failed to start Kafka producer.")
        {:error, "Failed to start producer"}

      {:error, _changeset} ->
        IO.puts("Failed to store order.")
        {:error, "Failed to store order"}

      error ->
        IO.puts("Unexpected error: #{inspect(error)}")
        {:error, inspect(error)}
    end
  end

end
