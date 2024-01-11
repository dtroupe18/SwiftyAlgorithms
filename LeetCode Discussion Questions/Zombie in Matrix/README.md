## Problem

Given a 2D grid, each cell is either a zombie 1 or a human 0. Zombies can turn
adjacent (up/down/left/right) human beings into zombies every hour.

Find out how many hours does it take to infect all humans?

## Example 1:

Input:

    [0, 1, 1, 0, 1],
    [0, 1, 0, 1, 0],
    [0, 0, 0, 0, 1],
    [0, 1, 0, 0, 0]

Output: `2`

## Explanation:

At the end of the 1st hour, the status of the grid:

    [1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [0, 1, 0, 1, 1],
    [1, 1, 1, 0, 1]

At the end of the 2nd hour, the status of the grid:

    [1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1]


## Example 2:

Input:

    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0]

Output: `4`

Explanation:
At the end of the 1st hour, the status of the grid:

    [0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 1, 1, 1, 0],
    [0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0]

At the end of the 2nd hour, the status of the grid:

    [0, 0, 1, 0, 0],
    [0, 1, 1, 1, 0],
    [1, 1, 1, 1, 1],
    [0, 1, 1, 1, 0],
    [0, 0, 1, 0, 0]

At the end of the 3nd hour, the status of the grid:

    [0, 1, 1, 1, 0],
    [1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [0, 1, 1, 1, 0]

At the end of the 4nd hour, the status of the grid:

    [1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1]

[Ref](https://leetcode.com/discuss/interview-question/411357/)
