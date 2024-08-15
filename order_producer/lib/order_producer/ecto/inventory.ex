defmodule OrderProducer.Inventory do
  use Ecto.Schema

  schema "inventory" do
    belongs_to :product, OrderProducer.Product
    field :quantity, :integer, default: 0
    timestamps()
  end
end
