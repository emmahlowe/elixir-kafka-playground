defmodule InventoryConsumer.MixProject do
  use Mix.Project

  def project do
    [
      app: :inventory_consumer,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {InventoryConsumer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:broadway_kafka, "~> 0.3"},
      {:jason, "~> 1.4"},
      {:ecto, "~> 3.6"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:mox, "~> 1.0", only: [:test]},
    ]
  end
end
