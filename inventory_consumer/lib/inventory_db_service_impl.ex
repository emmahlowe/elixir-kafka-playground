defmodule InventoryDbService do
  @behaviour DbService
  alias InventoryConsumer.Repo
  alias InventoryConsumer.Inventory

    #gets inventory item from db given product id
    def get_item(product_id) do
      Repo.get_by(Inventory, product_id: product_id)
    end

    #creates a changeset for updating the quantity on an inventory item
    def create_update_quantity_changeset(inventory_item, new_quantity) do
      inventory_item
      |> Ecto.Changeset.change(quantity: new_quantity)
    end

    #updates the inventory db given a changeset
    def update_database(changeset) do
      Repo.update(changeset)
    end

  end
