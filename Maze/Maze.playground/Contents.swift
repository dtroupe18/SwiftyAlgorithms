/**
 Problem

 Mooshak the mouse has been placed in a maze. There is a huge chunk of cheese somewhere in the maze.
 The maze is represented as a two-dimensional array of integers, where o represents walls, 1 represents paths where Mooshak can move, and 9 represents the huge chunk of cheese. Mooshak starts in the top-left corner at 0,0.

 Write a method isPath of class Maze Path to determine if Mooshak can reach the huge chunk of cheese. The input to isPath consists of a two dimensional array grid for the maze matrix.

 The method should return 1 if there is a path from Mooshak to the cheese, and 0 if not.
 Mooshak is not allowed to leave the maze or climb on walls/

 Example 8x8 maze where Mooshak can get the cheese.

 1 0 1 1 1 0 0 1
 1 0 0 0 1 1 1 1
 1 0 0 0 0 0 0 0
 1 0 1 0 9 0 1 1
 1 1 1 0 1 0 0 1
 1 0 1 0 1 1 0 1
 1 0 0 0 0 1 0 1
 1 1 1 1 1 1 1 1

 [Ref](https://leetcode.com/discuss/interview-question/algorithms/124715/amazon-is-cheese-reachable-in-the-maze)
 */

import Foundation
import XCTest

struct TestCase {
  let maze: [[Int]]
  let solution: Bool
}

final class MazeTests: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(
      maze: [
        [1, 0, 1, 1, 1, 0, 0, 1],
        [1, 0, 0, 0, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0],
        [1, 0, 1, 0, 9, 0, 1, 1],
        [1, 1, 1, 0, 1, 0, 0, 1],
        [1, 0, 1, 0, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 1, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1]
      ],
      solution: true
    ),
    TestCase(
      maze: [
        [1, 0, 1, 1, 1, 0, 0, 1],
        [1, 0, 0, 0, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0],
        [1, 0, 1, 0, 9, 0, 1, 1],
        [1, 1, 1, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 1, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1]
      ],
      solution: false
    ),
    TestCase(
      maze: [
        [1, 1, 1, 1, 1, 0, 0, 1],
        [1, 0, 0, 0, 1, 1, 1, 1],
        [1, 0, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 9, 0, 1, 1],
        [1, 1, 1, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 1, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1]
      ],
      solution: true
    ),
    TestCase(
      maze: [
        [1, 9]
      ],
      solution: true
    ),
    TestCase(
      maze: [
        [1, 0]
      ],
      solution: false
    ),
    TestCase(
      maze: [
        [1, 0, 1, 1, 1, 0, 0, 1],
        [0, 0, 0, 0, 1, 1, 1, 1],
        [1, 0, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 9, 0, 1, 1],
        [1, 1, 1, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 1, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1]
      ],
      solution: false
    ),
    TestCase(
      maze: [
        [0, 1, 1, 1, 1, 0, 0, 1],
        [1, 0, 0, 0, 1, 1, 1, 1],
        [1, 0, 0, 0, 1, 0, 0, 0],
        [1, 0, 1, 0, 9, 0, 1, 1],
        [1, 1, 1, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 1, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1]
      ],
      solution: false
    )
  ]

  /**
   Breadth First Search

   Time Complexity for BFS is O(V+E) in our case given and nxm maze
   we have n * m verticies and n * m * 4 edges.

   Space Complexity for BFS is usually O(V). In our case this would be O(n * m) because
   in the worse cause our queue holds all the verticies. However, we also have a visited array
   taking on O(n*m) space. However, this still results in O(n * m) space.
   */
  func isPathBFS(maze: [[Int]]) -> Bool {
    guard !maze.isEmpty, !maze[0].isEmpty, maze[0][0] == 1 else { return false }

    let directions = [(-1, 0), (1, 0), (0, 1), (0, -1)] // left, right, up, down.
    var q: [(row: Int, col: Int)] = [(row: 0, col: 0)]
    var visited: [[Bool]] = []

    for i in 0..<maze.count {
      for j in 0..<maze[i].count {
        if j == 0 {
          visited.append([false])
        } else {
          visited[i].append(false)
        }
      }
    }

    while !q.isEmpty {
      let current = q.removeLast()

      for direction in directions {
        let newRow = current.row + direction.0
        let newCol = current.col + direction.1

        if newRow >= 0, newRow < maze.count, newCol >= 0, newCol < maze[newRow].count, !visited[newRow][newCol] {
          visited[newRow][newCol] = true
          let mazeValue = maze[newRow][newCol]

          if mazeValue == 1 {
            q.append((row: newRow, col: newCol))
          } else if mazeValue == 9 {
            return true
          }
        }
      }
    }

    // Q is empty and we didn't reach 9 so it's not possible.
    return false
  }

  /**
   Depth First Search
   Same time and space complexity.
   */

  var reachedCheese: Bool = false
  var visited: [[Bool]] = []

  func isPathDFS(maze: [[Int]]) -> Bool {
    guard !maze.isEmpty, !maze[0].isEmpty, maze[0][0] == 1 else { return false }
    visited.removeAll()
    reachedCheese = false

    for i in 0..<maze.count {
      for j in 0..<maze[i].count {
        if j == 0 {
          visited.append([false])
        } else {
          visited[i].append(false)
        }
      }
    }

    // We only call this once because we have to reach it starting from 0, 0.
    depthFirstSearch(maze: maze, row: 0, col: 0)

    return reachedCheese
  }

  func depthFirstSearch(maze: [[Int]], row: Int, col: Int) {
    let directions = [(-1, 0), (1, 0), (0, 1), (0, -1)] // left, right, up, down.
    visited[row][col] = true

    for direction in directions {
      let newRow = row + direction.0
      let newCol = col + direction.1

      if newRow >= 0, newRow < maze.count, newCol >= 0, newCol < maze[newRow].count, !visited[newRow][newCol] {
        if maze[newRow][newCol] == 1 {
          depthFirstSearch(maze: maze, row: newRow, col: newCol)
        } else if maze[newRow][newCol] == 9 {
          reachedCheese = true
        }
      }
    }
  }

  func testIsPathBFS() {
    for (i, testCase) in testCases.enumerated() {
      let result = isPathBFS(maze: testCase.maze)
      let solution = testCase.solution

      XCTAssertEqual(result, solution, "Expected: \(solution) but got: \(result) for testCase: \(i)")
    }
  }

  func testIsPathDFS() {
    for (i, testCase) in testCases.enumerated() {
      let result = isPathDFS(maze: testCase.maze)
      let solution = testCase.solution

      XCTAssertEqual(result, solution, "Expected: \(solution) but got: \(result) for testCase: \(i)")
    }
  }
}

MazeTests.defaultTestSuite.run()
