defmodule InventoryConsumer.Repo do
  use Ecto.Repo,
    otp_app: :inventory_consumer,
    adapter: Ecto.Adapters.Postgres
end
