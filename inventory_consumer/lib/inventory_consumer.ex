defmodule InventoryConsumerBeh do
  @moduledoc """
  Defines the behaviour for a module that interacts with Kafka for consuming "OrderCreated" events,
  updates inventory levels in a PostgreSQL database, and publishes "InventoryUpdated" events back to Kafka.
  """

  @callback decode_event_message(message :: map()) :: {:ok, map()} | {:error, String.t()}
  @callback update_inventory_levels(data :: map()) :: {:ok, term()} | {:error, String.t()}
  @callback publish_inventory_updated_event() :: :ok
end
