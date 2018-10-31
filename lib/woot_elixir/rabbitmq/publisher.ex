defmodule WootElixir.RabbitMQ.Publisher do
  @moduledoc """
  Demo RabbitMQ publisher
  """

  @behaviour GenRMQ.Publisher

  require Logger

  def start_link() do
    GenRMQ.Publisher.start_link(__MODULE__, name: __MODULE__)
  end

  def init() do
    [
      exchange: "demo_exchange",
      uri: "amqp://guest:guest@localhost:5672"
    ]
  end

  def publish_message(message, routing_key) do
    Logger.info("Publishing message #{inspect(message)}")
    GenRMQ.Publisher.publish(__MODULE__, message, routing_key)
  end
end
