Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.


## Function Description

Complete the `countIslands` function. It must return the number of islands as an integer.

`countIslands` has the following parameter(s):

map: a 2 dimensional array of integers `[[Int]]`


## Input Format

`map` is an `n` x `m` Integer Array.


## Constraints

`map[n][m] == 0 || map[n][m] == 1`


## Output Format

Return the number of islands as a single integer.


## Sample Input 1

```
11110
11010
11000
00000
```

## Sample output 1

`1`

## Sample Input 2

```
11000
11000
00100
00011
```

## Sample output 2

`3`


## Explanation

In the first example all of the `1`'s are connect horizontally or vertically so there is only `1` island. In the second example we have `3` islands because islands are not connected diagonally.


## References:

[Graph Theory](https://en.wikipedia.org/wiki/Component_(graph_theory))

[Depth First Search](https://en.wikipedia.org/wiki/Depth-first_search)

[Breadth First Search](https://en.wikipedia.org/wiki/Breadth-first_search)
