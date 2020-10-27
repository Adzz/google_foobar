defmodule PleasePassTheCodedMessages do
  @moduledoc """
  Please Pass the Coded Messages
  ==============================

  You need to pass a message to the bunny prisoners, but to avoid detection, the code you agreed
  to use is... obscure, to say the least. The bunnies are given food on standard-issue prison
  plates that are stamped with the numbers 0-9 for easier sorting, and you need to combine sets of
  plates to create the numbers in the code. The signal that a number is part of the code is that
  it is divisible by 3. You can do smaller numbers like 15 and 45 easily, but bigger numbers like
  144 and 414 are a little trickier. Write a program to help yourself quickly create large numbers
  for use in the code, given a limited number of plates to work with.

  You have L, a list containing some digits (0 to 9). Write a function solution(L) which finds the
  largest number that can be made from some or all of these digits and is divisible by 3. If it is
  not possible to make such a number, return 0 as the solution. L will contain anywhere from 1 to 9
   digits.  The same digit may appear multiple times in the list, but each element in the list may
   only be used once.

  -- Python cases --
  Input:
  solution.solution([3, 1, 4, 1])
  Output:
      4311

  Input:
  solution.solution([3, 1, 4, 1, 5, 9])
  Output:
      94311
  """

  @doc """
  A NUMBER IS DIVISIBLE BY 3 IF ALL THE DIGITS ADD UP TO A NUMBER THAT IS DIVISIBLE BY 3.

  So we want to select the most number of digits that we can that will still all sum to a number
  divisible by 3.

  So we start with all of the digits and check do they all sum to a number divisible by 3?
  If not we want to check if there is a combination of 1 less digit that does. IF still not then drop
  two digits and so on.

  No which digit do we want to drop? The smallest one of course. Then the next smallest.

  So drop the smallest digit. Then we drop the next smallest digit (brining back the
  smallest digit) and so on.

  If still we haven't gotten to a number that works, we have to drop two digits. When we do that
  we drop the smallest and the next smallest. Then the smallest and the 3rd smallest etc

  Then we drop the second smallest and the third,
  """
  # We sort in reverse order because we are working with a linked list and I want to drop
  # the smallest number out the list. if we order by smallest first that would be done by
  # dropping the head which is well cheap. If we are careful we only need to sort the list once.
  def solution(list), do: do_solution(Enum.sort(list))

  def do_solution([]), do: 0

  def do_solution(sorted) do
    if sum_divisible_by_three(sorted) do
      create_largest_number(sorted)
    else
      [_ | rest] = sorted

      case check_dropping_smallest_digit(sorted, []) do
        :not_found -> do_solution(rest)
        number when is_number(number) -> number
      end
    end
  end

  def sum_divisible_by_three(list) do
    list
    |> Enum.sum()
    |> Integer.mod(3)
    |> Kernel.==(0)
  end

  def create_largest_number(list_of_numbers) do
    list_of_numbers
    |> Enum.reverse()
    |> Enum.join()
    |> String.to_integer()
  end

  def check_dropping_smallest_digit([], _visited), do: :not_found

  # so this whole thing is very cheeky. I think it is a zipper ? Essentially we skip the smallest
  # element that we haven't already visited in each iteration. We do that by adding the visited to
  # the existing
  def check_dropping_smallest_digit([smallest | rest], visited) do
    list = visited ++ rest

    if sum_divisible_by_three(list) do
      create_largest_number(list)
    else
      # the order or stuff is important here for perf.
      check_dropping_smallest_digit(rest, visited ++ [smallest])
    end
  end
end

PleasePassTheCodedMessages.solution([3, 1, 4, 1])
|> IO.inspect(limit: :infinity, label: "")

PleasePassTheCodedMessages.solution([3, 1, 4, 1, 5, 9])
|> IO.inspect(limit: :infinity, label: "")

PleasePassTheCodedMessages.solution([3, 10, 4, 1, 5, 9])
|> IO.inspect(limit: :infinity, label: "")

PleasePassTheCodedMessages.solution([1, 2])
|> IO.inspect(limit: :infinity, label: "")

PleasePassTheCodedMessages.solution([2, 1, 8])
|> IO.inspect(limit: :infinity, label: "")
