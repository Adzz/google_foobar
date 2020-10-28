  # Please Pass the Coded Messages
  # ==============================

  # You need to pass a message to the bunny prisoners, but to avoid detection, the code you agreed
  # to use is... obscure, to say the least. The bunnies are given food on standard-issue prison
  # plates that are stamped with the numbers 0-9 for easier sorting, and you need to combine sets of
  # plates to create the numbers in the code. The signal that a number is part of the code is that
  # it is divisible by 3. You can do smaller numbers like 15 and 45 easily, but bigger numbers like
  # 144 and 414 are a little trickier. Write a program to help yourself quickly create large numbers
  # for use in the code, given a limited number of plates to work with.

  # You have L, a list containing some digits (0 to 9). Write a function solution(L) which finds the
  # largest number that can be made from some or all of these digits and is divisible by 3. If it is
  # not possible to make such a number, return 0 as the solution. L will contain anywhere from 1 to 9
  #  digits.  The same digit may appear multiple times in the list, but each element in the list may
  #  only be used once.

  # -- Python cases --
  # Input:
  # solution.solution([3, 1, 4, 1])
  # Output:
  #     4311

  # Input:
  # solution.solution([3, 1, 4, 1, 5, 9])
  # Output:
  #     94311

def solution(l):
  """
  A NUMBER IS DIVISIBLE BY 3 IF ALL THE DIGITS ADD UP TO A NUMBER THAT IS DIVISIBLE BY 3.
  So the basic insight is to
  """
  return do_solution(sorted(l))

def do_solution(sorted):
  if len(sorted) == 0:
    return 0
  else:
    if sum_divisible_by_three(sorted):
      return create_largest_number(sorted)
    else:
      number_found = check_dropping_smallest_digit(sorted, [])
      if number_found == "not found":
        return do_solution(sorted[1:])
      else:
        return number_found

def sum_divisible_by_three(l):
  return sum(l) % 3 == 0

def create_largest_number(l):
  if len(l) == 0:
    return 0
  else:
    return int("".join(map(str, reversed(l))))

def check_dropping_smallest_digit(l, visited):
  if len(l) == 0:
    return "not found"
  else:
    rest = l[1:]
    list_to_check = visited + rest
    if sum_divisible_by_three(list_to_check):
      return create_largest_number(list_to_check)
    else:
      new = l[:]
      return check_dropping_smallest_digit(rest, visited + [new.pop(0)])


print(solution([3, 1, 4, 1]))
print(solution([3, 1, 4, 1, 5, 9]))
print(solution([1, 2]))
print(solution([2, 1, 8]))
print(solution([1,1,1,1,1,4,1,2]))















