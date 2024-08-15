defmodule OrderProducer.Order do
  use Ecto.Schema

  schema "orders" do
    field :quantity, :integer
    field :order_date, :naive_datetime
    belongs_to :product, OrderProducer.Product
  end

  def changeset(order_struct, attrs) do
    Ecto.Changeset.cast(order_struct, attrs, [:quantity, :order_date, :product_id])
    |> Ecto.Changeset.validate_required([:quantity, :order_date, :product_id])
    |> Ecto.Changeset.assoc_constraint(:product)
  end
end
