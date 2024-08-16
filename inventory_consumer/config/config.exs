import Config

config :inventory_consumer, InventoryConsumer.Repo,
  username: "elevate",
  password: "elevate",
  database: "ordersAndInventory",
  hostname: "localhost"

config :brod,
  clients: [
    my_client2: [
      endpoints: [
        localhost: 9092
      ],
      auto_start_producers: true,
      default_producer_config: [
        required_acks: 1
      ]
    ]
  ]

config :inventory_consumer, ecto_repos: [InventoryConsumer.Repo]
config :inventory_consumer, DbService, DbServiceMock
config :inventory_consumer, InventoryConsumer, InventoryConsumerMock
