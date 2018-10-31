defmodule WootElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    port = System.get_env("PORT") || "1337"
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: WootElixir.Router, options: [port: String.to_integer(port)]),
      # Supervisor.Spec.supervisor(WootElixir.RabbitMQ.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: WootElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
