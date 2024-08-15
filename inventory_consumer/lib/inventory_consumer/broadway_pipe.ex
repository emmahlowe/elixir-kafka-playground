defmodule MyBroadway do
  use Broadway

  def start_link(_opts) do
    IO.write("console log 1")
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9092],
             group_id: "inventory_consumer",
             topics: ["orders"]
           ]},
        concurrency: 1
      ],
      processors: [
        default: [
          concurrency: 2
        ]
      ],
      batchers: [
        default: [
          batch_size: 100,
          batch_timeout: 200,
          concurrency: 10
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, message, _) do
    InventoryConsumer.decode_event_message(message)
    message
  end

  @impl true
  def handle_batch(_, messages, _, _) do
    messages
  end
end
