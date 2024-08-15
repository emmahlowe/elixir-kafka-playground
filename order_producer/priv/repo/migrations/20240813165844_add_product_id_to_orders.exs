defmodule OrderProducer.Repo.Migrations.AddProductIdToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :product_id, references(:products, on_delete: :nothing)
    end
  end
end
