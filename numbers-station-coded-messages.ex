defmodule NumbersStationCodedMessages do
  @moduledoc """
  Numbers Station Coded Messages
  ==============================

  When you went undercover in Commander Lambda's organization, you set up a coded messaging system
  with Bunny Headquarters to allow them to send you important mission updates. Now that you're here
  and promoted to Henchman, you need to make sure you can receive those messages - but since you
  need to sneak them past Commander Lambda's spies, it won't be easy!

  Bunny HQ has secretly taken control of two of the galaxy's more obscure numbers stations, and
  will use them to broadcast lists of numbers. They've given you a numerical key, and their
  messages will be encrypted within the first sequence of numbers that adds up to that key within
  any given list of numbers.

  Given a non-empty list of positive integers l and a target positive integer t, write a function
  solution(l, t) which verifies if there is at least one consecutive sequence of positive integers
  within the list l (i.e. a contiguous sub-list) that can be summed up to the given target positive
  integer t (the key) and returns the lexicographically smallest list containing the smallest start
  and end indexes where this sequence can be found, or returns the array [-1, -1] in the case that
  there is no such sequence (to throw off Lambda's spies, not all number broadcasts will contain a
  coded message).

  For example, given the broadcast list l as [4, 3, 5, 7, 8] and the key t as 12, the function
  solution(l, t) would return the list [0, 2] because the list l contains the sub-list [4, 3, 5]
  starting at index 0 and ending at index 2, for which 4 + 3 + 5 = 12, even though there is a
  shorter sequence that happens later in the list (5 + 7). On the other hand, given the list
  l as [1, 2, 3, 4] and the key t as 15, the function solution(l, t) would return [-1, -1]
  because there is no sub-list of list l that can be summed up to the given target value t = 15.

  To help you identify the coded broadcasts, Bunny HQ has agreed to the following standards:

  - Each list l will contain at least 1 element but never more than 100.
  - Each element of l will be between 1 and 100.
  - t will be a positive integer, not exceeding 250.
  - The first element of the list l has index 0.
  - For the list returned by solution(l, t), the start index must be equal or smaller than the end index.

  Remember, to throw off Lambda's spies, Bunny HQ might include more than one contiguous sublist
  of a number broadcast that can be summed up to the key. You know that the message will always
  be hidden in the first sublist that sums up to the key, so solution(l, t) should only return
  that sublist.

  So we want the first, smallest list sub list of integers that sum to reach the target t.
  """

  @doc """
  Really there is a loop and an inner loop. But confusing thing is they can both be served by
  the same function.

  ### Examples

      iex> NumbersStationCodedMessages.solution([4, 3, 5, 7, 8], 12)
      [0, 2]

      iex> NumbersStationCodedMessages.solution([1, 2, 3, 4], 15)
      [-1, -1]

      iex> NumbersStationCodedMessages.solution([1, 2, 3, 4, 5], 12)
      [2, 4]

      iex> NumbersStationCodedMessages.solution([1, 2, 3, 4], 1)
      [0, 0]

      iex> NumbersStationCodedMessages.solution([1, 2, 3, 4], 4)
      [3, 3]

      iex> NumbersStationCodedMessages.solution([1, 2, 3, 4], 2)
      [1, 1]
  """
  def solution(list, target_sum) do
    Enum.with_index(list)
    |> Enum.reduce_while([-1, -1], fn {number, current_start_index}, indexes ->
      # drop all elements up to the current element. Prepend with a 0 value
      rest = [0 | Enum.drop(list, current_start_index + 1)]

      Enum.with_index(rest)
      |> Enum.reduce_while({number, [current_start_index, -1]}, fn {next_number,
                                                                    current_end_index},
                                                                   {running_total, acc} ->
        case running_total + next_number do
          total when total === target_sum ->
            {:halt, {total, [current_start_index, current_start_index + current_end_index]}}

          total when total > target_sum ->
            {:halt, {total, acc}}

          total when total < target_sum ->
            {:cont, {total, acc}}
        end
      end)
      |> case do
        {_, [_, -1]} -> {:cont, indexes}
        # How do we break out here. Reduce While
        {^target_sum, result} -> {:halt, result}
      end
    end)
  end
end

NumbersStationCodedMessages.solution([1, 2], 2) |> IO.inspect(limit: :infinity, label: "")
NumbersStationCodedMessages.solution([], 7) |> IO.inspect(limit: :infinity, label: "")

NumbersStationCodedMessages.solution([4, 3, 5, 7, 8], 7)
|> IO.inspect(limit: :infinity, label: "")

NumbersStationCodedMessages.solution([4, 3, 5, 7, 8], 12)
|> IO.inspect(limit: :infinity, label: "")

NumbersStationCodedMessages.solution([1, 2, 4, 3, 5, 7, 8], 12)
|> IO.inspect(limit: :infinity, label: "")

NumbersStationCodedMessages.solution([1, 2, 4], 30) |> IO.inspect(limit: :infinity, label: "")
NumbersStationCodedMessages.solution([1, 2, 4], 1) |> IO.inspect(limit: :infinity, label: "")
NumbersStationCodedMessages.solution([18, 18, 12], 12) |> IO.inspect(limit: :infinity, label: "")

NumbersStationCodedMessages.solution([10, 2, 10, 2], 12)
|> IO.inspect(limit: :infinity, label: "")

NumbersStationCodedMessages.solution([1, 18, 12], 18) |> IO.inspect(limit: :infinity, label: "")

NumbersStationCodedMessages.solution(Enum.to_list(1..100), 12)
|> IO.inspect(limit: :infinity, label: "")

NumbersStationCodedMessages.solution(Enum.to_list(99..1), 12)
|> IO.inspect(limit: :infinity, label: "")

NumbersStationCodedMessages.solution([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 13)
|> IO.inspect(limit: :infinity, label: "")
