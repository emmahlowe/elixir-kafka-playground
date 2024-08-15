defmodule OrderProducer.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :quantity, :integer
      add :order_date, :timestamp
    end
  end
end
