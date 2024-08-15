import Config

config :order_producer, OrderProducer.Repo,
  username: "elevate",
  password: "elevate",
  database: "ordersAndInventory",
  hostname: "localhost"

config :order_producer,
ecto_repos: [OrderProducer.Repo]

config :brod,
  clients: [
    my_client: [
      endpoints: [
        localhost: 9092
      ],
      auto_start_producers: true,
      default_producer_config: [
        required_acks: 1
      ]
    ]
  ]
#import_config "#{config_env()}.exs"
