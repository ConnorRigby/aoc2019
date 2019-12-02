defmodule AOC2019.Day1Test do
  use ExUnit.Case
  alias AOC2019.Day1

  test "examples" do
    assert Day1.calculate_fuel(12) == 2
    assert Day1.calculate_fuel(14) == 2
    assert Day1.calculate_fuel(1969) == 654
    assert Day1.calculate_fuel(100_756) == 33583
  end
end
