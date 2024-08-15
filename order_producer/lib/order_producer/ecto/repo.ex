defmodule OrderProducer.Repo do
  use Ecto.Repo,
    otp_app: :order_producer,
    adapter: Ecto.Adapters.Postgres
end
