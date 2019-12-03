defmodule AOC2019.Day2 do
  @moduledoc """
  To do this, before running the program, replace position 
  1 with the value 12 and replace position 2 with the value 2. 
  What value is left at position 0 after the program halts?
  """

  @external_resource "input/day2.txt"
  @input File.read!(@external_resource)
  def input,
    do:
      @input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

  def run(input \\ input(), pc \\ 0)

  def run(input, pc) do
    case :lists.nth(pc + 1, input) do
      99 ->
        input

      1 ->
        {_, [arg1, arg2, arg3 | _]} = :lists.split(pc + 1, input)

        exec(input, :add, {arg1, arg2, arg3})
        |> run(pc + 4)

      2 ->
        {_, [arg1, arg2, arg3 | _]} = :lists.split(pc + 1, input)

        exec(input, :mult, {arg1, arg2, arg3})
        |> run(pc + 4)
    end
  end

  def exec(input, :add, {arg1_address, arg2_address, result_address}) do
    arg1_value = :lists.nth(arg1_address + 1, input)
    arg2_value = :lists.nth(arg2_address + 1, input)
    list_replace(input, arg1_value + arg2_value, result_address)
  end

  def exec(input, :mult, {arg1_address, arg2_address, result_address}) do
    arg1_value = :lists.nth(arg1_address + 1, input)
    arg2_value = :lists.nth(arg2_address + 1, input)
    list_replace(input, arg1_value * arg2_value, result_address)
  end

  def list_replace(list, value, address) do
    {prefix, [_replace | suffix]} = :lists.split(address, list)
    prefix ++ [value | suffix]
  end
end
