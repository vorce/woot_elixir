defmodule WootElixir.RabbitMQ.Supervisor do
  @moduledoc """
  Supervises the RabbitMQ workers
  """
  alias WootElixir.RabbitMQ

  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(RabbitMQ.Consumer, []),
      worker(RabbitMQ.Publisher, [])
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    supervise(children, opts)
  end
end
