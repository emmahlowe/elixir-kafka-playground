defmodule InventoryConsumer.Product do
  use Ecto.Schema

  schema "products" do
    field :name, :string
    field :description, :string
    field :price, :float
  end
end
