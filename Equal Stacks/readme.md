You have three stacks of cylinders where each cylinder has the same diameter, but they may vary in height. You can change the height of a stack by removing and discarding its topmost cylinder any number of times.

Find the maximum possible height of the stacks such that all of the stacks are exactly the same height. This means you must remove zero or more cylinders from the top of zero or more of the three stacks until they're all the same height, then print the height. The removals must be performed in such a way as to maximize the height.

Note: An empty stack is still a stack.


## Constraints

1. `0 < n1, n2, n3 <= 10^5`
2. `0 < height of any cylinder <= 100`


## Example 1

```
h1: [3, 2, 1, 1, 1]
h2: [4, 3, 2]
h3: [1, 1, 4, 1]

Solution: 5

Observe that the three stacks are not all the same height. To make all stacks of equal height, we remove the first cylinder from stacks 1 and 2, and then remove the top two cylinders from stack 3.
```

## Example 2

```
h1: [3, 10]
h2: [4, 5]
h3: [2, 1]

Solution: 0

Sum can only be equal after removing all elements 
from all stacks.
```
