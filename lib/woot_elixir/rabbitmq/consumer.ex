defmodule WootElixir.RabbitMQ.Consumer do
  @moduledoc "Demo rabbitmq consumer"

  @behaviour GenRMQ.Consumer

  require Logger

  def start_link() do
    GenRMQ.Consumer.start_link(__MODULE__, name: __MODULE__)
  end

  def init() do
    Logger.info("Starting RabbitMQ consumer...")

    [
      queue: "woot-elixir",
      exchange: "woot-elixir",
      routing_key: "#",
      prefetch_count: "2",
      uri: "amqp://guest:guest@localhost:5672",
      retry_delay_function: fn attempt -> :timer.sleep(2000 * attempt) end
    ]
  end

  def consumer_tag() do
    "woot-elixir-consumer"
  end

  def handle_message(%GenRMQ.Message{payload: payload} = message) do
    {:ok, data} = Jason.decode(payload)
    {:ok, transformed} = transform(data)
    Logger.info("Result: #{inspect(transformed)}")
    GenRMQ.Consumer.ack(message)
  end

  @doc """
  Transforms a map of key values to the map of value, keys

  ## Examples

      iex> WootElixir.RabbitMQ.Consumer.transform(%{key: "value", otherkey: "value"})
      {:ok, %{"value" => [:otherkey, :key]}}
  """
  def transform(input) when is_map(input) do
    result = Enum.reduce(input, %{}, fn {key, val}, acc ->
      Map.update(acc, val, [key], fn existing ->
        [key|existing]
      end)
    end)
    {:ok, result}
  end
  def transform(_), do: {:error, :not_a_map}
end
