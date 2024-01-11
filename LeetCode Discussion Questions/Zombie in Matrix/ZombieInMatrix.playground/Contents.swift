/**
 Problem

 Given a 2D grid, each cell is either a zombie 1 or a human 0. Zombies can turn
 adjacent (up/down/left/right) human beings into zombies every hour.

 Find out how many hours does it take to infect all humans?

 Example 1:

 Input:
 [[0, 1, 1, 0, 1],
 [0, 1, 0, 1, 0],
 [0, 0, 0, 0, 1],
 [0, 1, 0, 0, 0]]

 Output: 2

 Explanation:
 At the end of the 1st hour, the status of the grid:
 [[1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1],
 [0, 1, 0, 1, 1],
 [1, 1, 1, 0, 1]]

 At the end of the 2nd hour, the status of the grid:
 [[1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1]]

 Example 2:

 Input:
 [0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0],
 [0, 0, 1, 0, 0],
 [0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0]

 Output: 4

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
 */

import XCTest
import Foundation

struct TestCase {
  let rows: Int
  let columns: Int
  let matrix: [[Int]]
  let solution: Int
}

final class ZombiesInMatrix: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(
      rows: 4,
      columns: 5,
      matrix: [[0, 1, 1, 0, 1],
               [0, 1, 0, 1, 0],
               [0, 0, 0, 0, 1],
               [0, 1, 0, 0, 0]],
      solution: 2
    ),
    TestCase(
      rows: 1,
      columns: 5,
      matrix: [[0, 0, 1, 0, 0]],
      solution: 2
    ),
    TestCase(
      rows: 5,
      columns: 5,
      matrix: [[0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0],
               [0, 0, 1, 0, 0],
               [0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0]],
      solution: 4
    )
  ]

  /**
   Right away to solve this you should be thinking BFS. Enqueue all over the `1`s then each iteration of BFS
   will represent 1 hour. Once the entire grid is `1` we are finished. The number of calls to BFS will represent the
   solution.
   */
  func calculateMinHours(rows: Int, columns: Int, grid: [[Int]]) -> Int {
    guard rows > 0, columns > 0, !grid.isEmpty else { return -1 }

    // Swift doesn't have Queues, but we could easily implement one.
    var queue: [(row: Int, col: Int)] = [] // (row, col)

    var map = grid
    var zombieCount: Int = 0
    var fullyInfectedCount: Int = 0

    // First we need to find all of the 1's and put them in the queue.
    for (i, row) in grid.enumerated() {
      for (j, value) in row.enumerated() {
        if value == 1 {
          zombieCount += 1
          queue.append((row: i, col: j))
        }

        // I didn't assume the grid was square.
        fullyInfectedCount += 1
      }
    }

    guard zombieCount != fullyInfectedCount else { return 0 }
    guard zombieCount > 0 else { return -1 }

    var hoursToInfectEveryone: Int = 0
    let directions: [(Int, Int)] = [(0, 1), (0, -1), (1, 0), (-1, 0)]

    while !queue.isEmpty {
      let size = queue.count
      guard zombieCount != fullyInfectedCount else { return hoursToInfectEveryone }

      // For everything in the queue we infect all of their neighbors.
      for _ in 0..<size {
        let (row, col) = queue.removeFirst()

        for direction in directions {
          let newRow = row + direction.0
          let newCol = col + direction.1

          if newRow >= 0, newRow < grid.count, newCol >= 0, newCol < map[newRow].count, map[newRow][newCol] == 0 {
            // Infect these people.
            map[newRow][newCol] = 1
            zombieCount += 1

            // Add this space to the queue to infect people next hour.
            queue.append((row: newRow, col: newCol))
          }
        }
      }

      hoursToInfectEveryone += 1

#if DEBUG
      print("hoursToInfectEveryone: \(hoursToInfectEveryone)")
      for row in map {
        print(row)
      }

      print("\n")
#endif
    }

    return hoursToInfectEveryone
  }

  func testCalculateMinHours() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let hours = calculateMinHours(rows: testCase.rows, columns: testCase.columns, grid: testCase.matrix)

      XCTAssert(hours == solution, "Expected: \(solution) but got: \(hours) for testCase \(i)")
    }
  }
}

ZombiesInMatrix.defaultTestSuite.run()
