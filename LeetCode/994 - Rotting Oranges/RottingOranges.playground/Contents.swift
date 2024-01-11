/**
 Problem

 In a given grid, each cell can have one of three values:

 the value 0 representing an empty cell;
 the value 1 representing a fresh orange;
 the value 2 representing a rotten orange.
 Every minute, any fresh orange that is adjacent (4-directionally) to a rotten orange becomes rotten.

 Return the minimum number of minutes that must elapse until no cell has a fresh orange.
 If this is impossible, return -1 instead.

 Example 1:

 Input: [[2,1,1],[1,1,0],[0,1,1]]
 Output: 4

 Explanation:

 [2, 1, 1]       [2, 2, 1]       [2, 2, 2]       [2, 2, 2]      [2, 2, 2]
 [1, 1, 0]  -->  [2, 1, 0]  -->  [2, 2, 0]  -->  [2, 2, 0]  --> [2, 2, 0]
 [0, 1, 1]       [0, 1, 1]       [0, 1, 1]       [0, 2, 1]      [0, 2, 2]


 Example 2:

 Input: [[2,1,1],[0,1,1],[1,0,1]]
 Output: -1

 Explanation:

 The orange in the bottom left corner (row 2, column 0) is never rotten, because rotting only happens 4-directionally.


 Example 3:

 Input: [[0,2]]
 Output: 0

 Explanation:

 Since there are already no fresh oranges at minute 0, the answer is just 0.


 Note:

 1 <= grid.length <= 10
 1 <= grid[0].length <= 10
 grid[i][j] is only 0, 1, or 2.

 [Ref](https://leetcode.com/problems/rotting-oranges/)

 */

import Foundation
import XCTest

struct TestCase {
  let grid: [[Int]]
  let solution: Int
}

final class RottingOragesTests: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(grid: [[2,1,1],[1,1,0],[0,1,1]], solution: 4),
    TestCase(grid: [[2,1,1],[0,1,1],[1,0,1]], solution: -1),
    TestCase(grid: [[0,2]], solution: 0)
  ]

  // Runtime: 24 ms, faster than 94.58% of Swift online submissions for Rotting Oranges.
  // Memory Usage: 21 MB, less than 100.00% of Swift online submissions for Rotting Oranges.
  //
  // Complexity:
  // The Time complexity of both BFS O(V + E), given an n x m sized array we have about
  // n * m verticies and almost 4*n*m edges. So in this cause the complexity for BFS alone
  // will be O(n*m).
  func orangesRotting(_ grid: [[Int]]) -> Int {
    guard !grid.isEmpty else { return -1 }

    var currentGrid = grid
    var rottenOrangeCount: Int = 0
    var freshOrangeCount: Int = 0
    var queue: [(row: Int, col: Int)] = []

    for (i, row) in grid.enumerated() {
      for (j, value) in row.enumerated() {
        if value == 1 {
          freshOrangeCount += 1
        } else if value == 2 {
          rottenOrangeCount += 1
          queue.append((row: i, col: j))
        }
      }
    }

    guard freshOrangeCount > 0 else { return 0 }
    guard rottenOrangeCount > 0 else { return -1 }

    var minutesToGoRotten: Int = 0

    // up, down, left, right.
    let directions: [(Int, Int)] = [(0, 1), (0, -1), (1, 0), (-1, 0)]

    // BFS - since we are expanding out.
    while !queue.isEmpty {
      if freshOrangeCount == 0 { return minutesToGoRotten }

      let size = queue.count

      for _ in 0..<size {
        let (row, col) = queue.removeFirst()

        for direction in directions {
          let newRow = row + direction.0
          let newCol = col + direction.1

          if newRow >= 0, newRow < grid.count, newCol >= 0, newCol < grid[newRow].count, currentGrid[newRow][newCol] == 1 {
            // This orange is now rotten.
            currentGrid[newRow][newCol] = 2
            freshOrangeCount -= 1
            queue.append((row: newRow, col: newCol))
          }
        }
      }

      minutesToGoRotten += 1
    }

    if freshOrangeCount > 0 {
      // Impossible
      return -1
    }

    return minutesToGoRotten
  }

  func testOrangesRotting() {
    for (i, testCase) in testCases.enumerated() {
      let result = orangesRotting(testCase.grid)
      let solution = testCase.solution

      XCTAssertEqual(result, solution, "Expected: \(solution), but got: \(result) for test case: \(i)")
    }
  }
}

RottingOragesTests.defaultTestSuite.run()
