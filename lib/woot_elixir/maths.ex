defmodule WootElixir.Maths do
  @moduledoc "Provides maths functions"

  @doc """
  Integer division

  ## Examples

      iex> WootElixir.Maths.divide(10, 2)
      5
  """
  @spec divide(dividend :: integer, divisor :: integer) :: integer
  def divide(dividend, divisor) do
    div(dividend, divisor)
  end

  @doc "Calculate the n:th fibonacci number"
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) do
    fib(n - 1) + fib(n - 2)
  end
end
