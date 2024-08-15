defmodule InventoryConsumer.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      InventoryConsumer.Repo,
      MyBroadway
    ]
    opts = [strategy: :one_for_one, name: InventoryConsumer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
