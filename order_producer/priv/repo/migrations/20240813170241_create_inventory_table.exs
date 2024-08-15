defmodule OrderProducer.Repo.Migrations.CreateInventoryTable do
  use Ecto.Migration

  def change do
    create table(:inventory) do
      add :product_id, references(:products, on_delete: :restrict)
      add :quantity, :integer, default: 0
      timestamps()
    end
  end
end
