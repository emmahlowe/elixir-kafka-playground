defmodule InventoryDbServiceTest do
  use ExUnit.Case, async: true
  import Mox

 # Confirm that Mox is allowed to work in this test case
 setup :verify_on_exit!

 describe "get_inventory_item/1" do
   test "returns an inventory item when found" do
     # Setup the expected behavior
     expect(DbServiceMock, :get_inventory_item, fn 123 ->
       %InventoryConsumer.Inventory{id: 123, product_id: 123, quantity: 10}
     end)

     # Use the function
     result = DbServiceMock.get_inventory_item(123)

     # Verify the expected result
     assert %InventoryConsumer.Inventory{id: 123, product_id: 123, quantity: 10} = result
   end

   test "returns nil if item not found" do
     expect(DbServiceMock, :get_inventory_item, fn 999 -> nil end)
     assert DbServiceMock.get_inventory_item(999) == nil
   end
 end
end
