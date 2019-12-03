defmodule AOC2019.Day2 do
  @moduledoc """
  To do this, before running the program, replace position 
  1 with the value 12 and replace position 2 with the value 2. 
  What value is left at position 0 after the program halts?

  Find the input noun and verb that cause the program to produce the
  output 19690720. What is 100 * noun + verb? (For example, if noun=12 and verb=2, 
  the answer would be 1202.)
  """

  @external_resource "input/day2.txt"
  @input File.read!(@external_resource)
  _ = File.mkdir_p(".cache/day2")

  def input(noun, verb),
    do:
      @input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> list_replace(noun, 1)
      |> list_replace(verb, 2)

  def solve(noun, verb, expected_answer) do
    answer =
      case File.read(".cache/day2/#{noun}.#{verb}") do
        {:error, :enoent} ->
          answer = run(noun, verb)
          File.write(".cache/day2/#{noun}.#{verb}", to_string(answer))
          answer

        {:ok, answer_str} ->
          answer_str |> String.trim() |> String.to_integer()
      end

    if answer == expected_answer do
      100 * noun + verb
    else
      if noun == 99 do
        solve(0, verb + 1, expected_answer)
      else
        solve(noun + 1, verb, expected_answer)
      end
    end
  end

  def run(noun, verb) do
    [_, noun, verb | _] = initial_memory = input(noun, verb)
    [result | _] = do_run(initial_memory)
    IO.puts("noun=#{noun} verb=#{verb} result=#{result}")
    # {(100 * noun) + verb, result}
    result
  end

  def do_run(input, pc \\ 0)

  def do_run(input, pc) do
    case :lists.nth(pc + 1, input) do
      99 ->
        input

      1 ->
        {_, [arg1, arg2, arg3 | _]} = :lists.split(pc + 1, input)

        exec(input, :add, {arg1, arg2, arg3})
        |> do_run(pc + 4)

      2 ->
        {_, [arg1, arg2, arg3 | _]} = :lists.split(pc + 1, input)

        exec(input, :mult, {arg1, arg2, arg3})
        |> do_run(pc + 4)
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
