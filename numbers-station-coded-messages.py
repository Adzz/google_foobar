"""
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

def solution(l, target_sum):
    """
    I think we need to like window across it. We need to be like first element, plus next
    then next until we > it. then try drop the first element and do the same again.
    so on until we get to the end of the list or find a sublist.

    That means... worst case is when there is no sublist, and the sum of all elements is less than
    the desired number.

    So it's O(log n ^n) or O(n^log n) ? For every element you have to check that element against the rest of the list
    there's a loop in a loop
    but the rest of the list decreases each iteration.

    We need to keep some state: the running total of the sum, the starting index.
    """

    result = [-1, -1]
    if not l:
        return result
    for current_start_index, number in enumerate(l):
        running_total = number
        inner_result = [current_start_index, -1]
        for current_end_index, next_number in enumerate([0] + l[current_start_index + 1:]):
            if running_total + next_number == target_sum:
                return [current_start_index, current_start_index + current_end_index]
            elif next_number + running_total > target_sum:
                break
            else:
                running_total += next_number
        if inner_result[1] > -1:
            result = inner_result
    return result

print(solution([], 7))
print(solution([4, 3, 5, 7, 8], 7))
print(solution([4, 3, 5, 7, 8], 12))
print(solution([1, 2, 4, 3, 5, 7, 8], 12))
print(solution([1, 2, 4], 30))
print(solution([1, 2, 4], 1))
print(solution([18, 18, 12], 12))
print(solution([10,2, 10, 2], 12))
print(solution([1, 18, 12], 18))
print(solution(list(range(1, 100)), 12))
print(solution(list(reversed(list(range(1, 100)))), 12))
print(solution([10,9,8,7,6,5,4,3,2,1], 13))













