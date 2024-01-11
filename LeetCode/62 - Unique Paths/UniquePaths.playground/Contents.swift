/**
 Problem

 A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).

 The robot can only move either down or right at any point in time.
 The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).

 How many possible unique paths are there?

 Example 1:

 Input: m = 3, n = 2
 Output: 3

 Explanation:

 From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:
 1. Right -> Right -> Down
 2. Right -> Down -> Right
 3. Down -> Right -> Right


 Example 2:

 Input: m = 7, n = 3
 Output: 28

 [Ref](https://leetcode.com/problems/unique-paths/)
 */

import Foundation
import XCTest

struct TestCase {
  let m: Int
  let n: Int
  let solution: Int
}

final class UniquePathTests: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(m: 3, n: 2, solution: 3),
    TestCase(m: 7, n: 3, solution: 28),
    TestCase(m: 3, n: 6, solution: 21)
  ]

  // Runtime: 4 ms, faster than 89.95% of Swift online submissions for Unique Paths.
  // Memory Usage: 21.1 MB, less than 50.00% of Swift online submissions for Unique Paths.
  //
  // Complexity O(mn) for time and space
  func uniquePaths(_ m: Int, _ n: Int) -> Int {
    let rows = m
    let cols = n

    guard rows > 0, cols > 0 else { return 0 }

    var pathCounts: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)

    // Everything in the first column has 1 path.
    for i in 0..<rows {
      pathCounts[i][0] = 1
    }

    // Everything in the first row has 1 path.
    for i in 0..<cols {
      pathCounts[0][i] = 1
    }

    // Every other square has the sum of the paths to the space above, and the space to the left.
    // This is because the square above and the square to the left are the only square the robot
    // can move into the current square from.
    for i in 1..<rows {
      for j in 1..<cols {
        pathCounts[i][j] = pathCounts[i - 1][j] + pathCounts[i][j - 1]
      }
    }

    return pathCounts[rows - 1][cols - 1]
  }

  func testUniquePaths() {
    for (i, testCase) in testCases.enumerated() {
      let result = uniquePaths(testCase.m, testCase.n)
      let solution = testCase.solution

      XCTAssertEqual(result, solution, "Expected: \(solution), but got: \(result) for test case: \(i)")
    }
  }
}

UniquePathTests.defaultTestSuite.run()
