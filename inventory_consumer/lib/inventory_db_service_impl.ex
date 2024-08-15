defmodule InventoryDbService do
  @behaviour DbService
  alias InventoryConsumer.Repo
  alias InventoryConsumer.Inventory

    def get_inventory_item(product_id) do
      Repo.get_by(Inventory, product_id: product_id)
    end

    def create_update_quantity_changeset(inventory_item, new_quantity) do
      inventory_item
      |> Ecto.Changeset.change(quantity: new_quantity)
    end

    def update_database(changeset) do
      Repo.update(changeset)
    end
  end
