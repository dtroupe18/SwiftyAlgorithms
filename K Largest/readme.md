Write an efficient program for printing k largest elements in an array. Elements in array can be in any order.
For example, if given array is `[1, 23, 12, 9, 30, 2, 50]` and you are asked for the largest 3 elements i.e., `k = 3` then your program should print `50, 30` and `23`.

## Solution
First sort the array `O(nlogn)` then return `k` elements `O(k)`.

Think of the worst case example: Given an array of length `n`, and `k = n`
then the solution requires us to sort the entire array. Since `O(nlogn)` is the best
we can hope for when sorting this will be the most efficient method.

## Alternate Solution

Algorithm Process:
  1. Initialize an array (largest) to store the k largest numbers in largest to smallest order.
  2. Insert the first element of the test array into this array (largest).
  3. Loop over the remainder of the test array O(n).
  4. For each element we compare it starting at the end of largest (smallest largest value).
     If the current element is larger than the smallest largest element, keep going until we find
     a value it's not greater than and insert it there. O(k).

     Time Complexity: O(n*k) -> Faster than the above method if k < log(n).
