defmodule InventoryConsumerTest do
  use ExUnit.Case, async: true
  import Mox

  # Setup Mox for each test
  setup :verify_on_exit!

  describe "decode_event_message/1" do
    test "handles successful JSON parsing and updates inventory levels" do
      # Prepare the input
      message = %{data: "{\"id\": 1, \"product_id\": 1, \"quantity\": 5, \"order_date\": 2024-08-13 17:11:58.225918}}"}

      # Mock the update_inventory_levels to just return :ok for simplicity
      expect(InventoryDbServiceMock, :get_inventory_item, fn _product_id ->
        {:ok, message}
      end)

      result = InventoryConsumer.decode_event_message(message)
      assert result == {:ok, message}
    end

    # test "handles JSON parsing errors" do
    #   # Prepare the input with bad JSON
    #   message = %{"data" => "bad json"}

    #   # Ensure it logs an error and returns an error tuple
    #   assert {:error, "JSON parsing failed"} = InventoryConsumer.decode_event_message(message)
    # end
  end

  describe "update_inventory_levels/1" do
    test "updates inventory levels when the item is found" do
      # Setup data
      data = %{
        id: 1,
        quantity: 1,
        order_date: "2024-08-13 17:11:58.225918",
        product_id: 1
      }
      inventory_item = %InventoryConsumer.Inventory{product_id: 1, quantity: 10}

      # Mock get_inventory_item to return the inventory item
      expect(DbServiceMock, :get_inventory_item, fn 1 -> inventory_item end)

      # Mock the remaining dependencies
      changeset = %{}
      expect(DbServiceMock, :create_update_quantity_changeset, fn _, _ -> changeset end)
      expect(DbServiceMock, :update_database, fn ^changeset -> {:ok, %InventoryConsumer.Inventory{quantity: 5}} end)

      assert {:ok, %InventoryConsumer.Inventory{quantity: 5}} = InventoryConsumer.update_inventory_levels(data)
    end

    test "returns an error if the inventory item is not found" do
      # Setup data
      data = %{"product_id" => 999, "quantity" => 5}

      # Mock get_inventory_item to return nil
      expect(DbServiceMock, :get_inventory_item, fn 999 -> nil end)

      assert {:error, "Inventory item not found"} = InventoryConsumer.update_inventory_levels(data)
    end
  end
end
