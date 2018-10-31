defmodule WootElixir.MathsRouter do
  use Plug.Router

  alias WootElixir.Maths

  plug :match
  plug :dispatch

  get "/div/:something/:divided_by" do
    dividend = String.to_integer(something)
    divisor = String.to_integer(divided_by)
    quotient = Maths.divide(dividend, divisor)

    send_resp(conn, 200, "#{quotient}")
  end

  get "/fib/:number" do
    result = number
    |> String.to_integer()
    |> Maths.fib()

    send_resp(conn, 200, "#{result}")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
