defmodule AOC2019.Day1 do
  @moduledoc """
  Fuel required to launch a given module is based on its mass. 
  Specifically, to find the fuel required for a module, 
  take its mass, divide by three, round down, and subtract 2.

  So, for each module mass, calculate its fuel and 
  add it to the total. Then, treat the fuel amount 
  you just calculated as the input mass and repeat the 
  process, continuing until a fuel requirement is zero 
  or negative
  """

  @external_resource "input/day1.txt"
  @input File.read!(@external_resource)
  def input,
    do:
      @input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)

  def calculate_fuel(input_num, acc \\ []) do
    case trunc(Float.floor(input_num / 3, 0) - 2) do
      output_num when output_num <= 0 ->
        Enum.reduce(acc, 0, fn output_num, acc -> output_num + acc end)

      output_num ->
        calculate_fuel(output_num, [output_num | acc])
    end
  end

  def solve do
    input()
    |> Enum.map(fn num ->
      Task.async(fn -> calculate_fuel(num) end)
    end)
    |> Enum.map(&Task.await/1)
    |> Enum.reduce(0, fn result, acc -> result + acc end)
  end
end
