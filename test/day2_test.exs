defmodule AOC2019.Day2Test do
  use ExUnit.Case
  alias AOC2019.Day2

  test "examples" do
    assert Day2.do_run([1, 0, 0, 0, 99]) == [2, 0, 0, 0, 99]
    assert Day2.do_run([2, 3, 0, 3, 99]) == [2, 3, 0, 6, 99]
    assert Day2.do_run([2, 4, 4, 5, 99, 0]) == [2, 4, 4, 5, 99, 9801]
    assert Day2.do_run([1, 1, 1, 4, 99, 5, 6, 0, 99]) == [30, 1, 1, 4, 2, 5, 6, 0, 99]
  end

  test "part 2 examples" do
    assert Day2.run(12, 2) == 3_706_713
  end
end
