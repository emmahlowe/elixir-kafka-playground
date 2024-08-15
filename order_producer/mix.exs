defmodule OrderProducer.MixProject do
  use Mix.Project

  def project do
    [
      app: :order_producer,
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
      mod: {OrderProducer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:broadway_kafka, "~> 0.3"},
      {:uuid, "~> 1.1" },
      {:jason, "~> 1.4"},
      {:ecto, "~> 3.6"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:brod, "~> 3.15"}
    ]
  end
end
