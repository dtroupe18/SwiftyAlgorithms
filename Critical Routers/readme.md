## Problem

You are given an undirected connected graph. An articulation point (or cut vertex) is defined as a vertex which, when removed along with associated edges, makes the graph disconnected (or more precisely, increases the number of connected components in the graph). The task is to find all articulation points in the given graph.

Input:

The input to the function/method consists of three arguments:

numNodes, an integer representing the number of nodes in the graph.
numEdges, an integer representing the number of edges in the graph.
edges, the list of pair of integers - A, B representing an edge between the nodes A and B.

Output:

Return a list of integers representing the critical nodes.

## Example 1:

Input:

numNodes = `7`,
numEdges = `7`,
edges = `[[0, 1], [0, 2], [1, 3], [2, 3], [2, 5], [5, 6], [3, 4]]`

          4
         /
        3
       / \
      1   2
       \ / \
        0   5
             \
              6

Output: `[2, 3, 5]`


## Example 2:

numNodes = `5`,
numEdges = `5`,
edges = `[[1, 2], [0, 1], [2, 0], [0, 3], [3, 4]]`

          0 -- 3
         / \    \
        1 - 2    4

Output: `[0, 3]`

[Ref](https://leetcode.com/discuss/interview-question/436073/)
