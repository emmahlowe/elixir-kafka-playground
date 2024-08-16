defmodule InventoryConsumer do
  @moduledoc """
  * Subscribes to "OrderCreated" events from Kafka
  * Updates inventory levels in PostgreSQLl
  * Publishes "InventoryUpdated" events to Kafka

  """
  @behaviour InventoryConsumerBeh

  def decode_event_message(message) do
    case Jason.decode(message.data) do
      {:ok, data} ->
        update_inventory_levels(data)

      {:error, _error} ->
        IO.puts("Failed to parse JSON")
        {:error, "JSON parsing failed"}
    end
end

  def update_inventory_levels(data) do
    product_id = data["product_id"]
    quantity = data["quantity"]
    IO.inspect({product_id, quantity}, label: "Extracted Data")

    case InventoryDbService.get_inventory_item(product_id) do
      nil ->
        {:error, "Inventory item not found"}

      inventory_item ->
        new_quantity = inventory_item.quantity - quantity
        changeset = InventoryDbService.create_update_quantity_changeset(inventory_item, new_quantity)

        InventoryDbService.update_database(changeset)
        publish_inventory_updated_event(data)
    end
  end

  def publish_inventory_updated_event(data) do
    IO.write("publishing inventory updated event")
    #create inventory updated message
    inventory_update = %{
      inventory_id: 1,
      new_quantity: data["quantity"],
      updated_on: data["order_date"]
    }
    #encode message
    json_message = EventProcessor.json_encode(inventory_update)
    EventProcessor.start_producer()
    #publish event to kafka
    EventProcessor.send_event(json_message)
  end
end
