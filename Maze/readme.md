## Problem

Mooshak the mouse has been placed in a maze. There is a huge chunk of cheese somewhere in the maze.
The maze is represented as a two-dimensional array of integers, where o represents walls, 1 represents paths where Mooshak can move, and 9 represents the huge chunk of cheese. Mooshak starts in the top-left corner at 0,0.

Write a method isPath of class Maze Path to determine if Mooshak can reach the huge chunk of cheese. The input to isPath consists of a two dimensional array grid for the maze matrix.

The method should return 1 if there is a path from Mooshak to the cheese, and 0 if not.
Mooshak is not allowed to leave the maze or climb on walls/

## Example 8x8 maze where Mooshak can get the cheese.

    1 0 1 1 1 0 0 1
    1 0 0 0 1 1 1 1
    1 0 0 0 0 0 0 0
    1 0 1 0 9 0 1 1
    1 1 1 0 1 0 0 1
    1 0 1 0 1 1 0 1
    1 0 0 0 0 1 0 1
    1 1 1 1 1 1 1 1

[Ref](https://leetcode.com/discuss/interview-question/algorithms/124715/amazon-is-cheese-reachable-in-the-maze)
