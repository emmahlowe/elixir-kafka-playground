defmodule OrderProducer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
#supervision tree
  @impl true
  def start(_type, _args) do
    children = [
      OrderProducer.Repo,
      # %{
      #   id: :brod_client,
      #   start: {:brod_client, :start_link, [[localhost: 9092], :my_client, []]},
      #   type: :worker,
      #   restart: :permanent,
      #   shutdown: 5000
      # },
      {Task, fn -> start_periodic_tasks() end}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OrderProducer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp start_periodic_tasks do
    # Wait 1 minute before starting the periodic task
    :timer.sleep(60_000)

    # Schedule send_message to run every 15 seconds
    :timer.send_interval(15_000, self(), :send_message)

    loop()
  end

  defp loop do
    receive do
      :send_message ->
        OrderProducer.send_message()
        loop()
      end
    end
end
