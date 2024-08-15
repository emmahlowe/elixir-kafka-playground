import Config

config :inventory_consumer, InventoryConsumer.Repo,
  username: "elevate",
  password: "elevate",
  database: "ordersAndInventory",
  hostname: "localhost"

config :inventory_consumer, ecto_repos: [InventoryConsumer.Repo]
# config/test.exs (or similar configuration)
config :inventory_consumer, DbService, DbServiceMock
config :inventory_consumer, InventoryConsumer, InventoryConsumerMock
