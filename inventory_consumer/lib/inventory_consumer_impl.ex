defmodule InventoryConsumer do
  @moduledoc """
  * Subscribes to "OrderCreated" events from Kafka
  * Updates inventory levels in PostgreSQLl
  * Publishes "InventoryUpdated" events to Kafka

  """
  @behaviour InventoryConsumerBeh

  #decode order event message
  def process_order_event(message) do
    case EventProcessor.json_decode(message.data) do
      {:ok, data} ->
        update_inventory_levels(data)

      {:error, reason} ->
        IO.puts("Failed to parse JSON: #{inspect(reason)}")
        {:error, "JSON parsing failed"}
    end
  end

  #updates inventory levels in db and moves inventory info along the business logic flow
  def update_inventory_levels(data) do
    product_id = data["product_id"]
    quantity = data["quantity"]
    IO.inspect({product_id, quantity}, label: "Extracted Data")

    #get inventory item as is
    case InventoryDbService.get_item(product_id) do
      nil ->
        IO.puts("Inventory item not found for product_id: #{product_id}")
        {:error, "Inventory item not found"}

      inventory_item ->
        new_quantity = inventory_item.quantity - quantity
        changeset = InventoryDbService.create_update_quantity_changeset(inventory_item, new_quantity)

        #update inventory item in db with new quantity
        case InventoryDbService.update_database(changeset) do
          {:ok, updated_record} ->
            #move on to updating inventory topic with inventory update message
            prepare_inventory_updated_event(data, updated_record)

          {:error, changeset} ->
            IO.inspect(changeset.errors, label: "Failed to update inventory")
            {:error, "Database update failed"}
        end
    end
  end


  def prepare_inventory_updated_event(data, inventory_record) do
    IO.inspect("Preparing inventory updated event #{inventory_record.id}")

    inventory_update = %{
      inventory_id: inventory_record.id,
      new_quantity: data["quantity"],
      updated_on: data["order_date"]
    }

    case EventProcessor.json_encode(inventory_update) do
      {:ok, data} ->
        send_event_to_kafka(data)

      {:error, reason} ->
        IO.puts("Failed to encode JSON: #{inspect(reason)}")
        {:error, "JSON encoding failed"}
    end
  end

  defp send_event_to_kafka(json_message) do
    case EventProcessor.start_producer() do
      :ok ->
        case EventProcessor.send_event(json_message) do
          :ok ->
            IO.puts("Event successfully published to Kafka")
            :ok

          {:error, reason} ->
            IO.puts("Failed to publish event to Kafka: #{inspect(reason)}")
            {:error, "Failed to publish event"}
        end

      {:error, reason} ->
        IO.puts("Failed to start Kafka producer: #{inspect(reason)}")
        {:error, "Failed to start producer"}
    end
  end
end
