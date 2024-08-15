defmodule InventoryConsumer.Inventory do
  use Ecto.Schema

  schema "inventory" do
    belongs_to :product, InventoryConsumer.Product
    field :quantity, :integer, default: 0
    timestamps()
  end
end
