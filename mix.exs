defmodule WootElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :woot_elixir,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {WootElixir.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # webserver
      {:cowboy, "~> 2.5"},

      # composable webapp modules
      {:plug, "~> 1.7"},

      # plug adapter for cowboy
      {:plug_cowboy, "~> 2.0"},

      # Behaviours for RabbitMQ consumers and publishers
      {:gen_rmq, "~> 1.0"},

      # JSON decoding and encoding
      {:jason, "~> 1.1"},

      {:ranch, "~> 1.6", override: true},
      {:ranch_proxy_protocol, "~> 2.0", override: true},
      {:lager, "~> 3.6", override: true}
    ]
  end
end
