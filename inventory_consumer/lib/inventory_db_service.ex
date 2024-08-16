defmodule DbService do
use Ecto.Schema
@callback get_inventory_item(product_id :: integer) :: InventoryConsumer.Inventory | nil
@callback create_update_quantity_changeset(inventory_item :: InventoryConsumer.Inventory, new_quantity :: integer) :: Ecto.Changeset.t()
@callback update_database(changeset :: Ecto.Changeset.t()) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

end
