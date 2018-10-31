defmodule WootElixir.MathsTest do
  use ExUnit.Case
  doctest WootElixir.Maths

  alias WootElixir.Maths

  describe "fib/1" do
    test "base cases" do
      assert Maths.fib(0) == 0
      assert Maths.fib(1) == 1
    end

    test "the seventh fibonacci number is 13" do
      assert Maths.fib(7) == 13
    end
  end
end
