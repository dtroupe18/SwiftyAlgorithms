import Foundation
import XCTest

struct IslandTestCase {
  let map: [[Int]]
  let solution: Int
}

final class CountTheIslandsTests: XCTestCase {
  // Reset this for each test case.
  private var visited: [[Bool]] = []

  private let testCases: [IslandTestCase] = [
    IslandTestCase(
      map: [
        [1, 1, 0, 0, 0],
        [0, 1, 0, 0, 1],
        [1, 0, 0, 1, 1],
        [0, 0, 0, 0, 0],
        [1, 0, 1, 0, 1]
      ],
      solution: 6
    ),
    IslandTestCase(
      map: [
        [1, 1, 1, 1, 0],
        [1, 1, 0, 1, 0],
        [1, 1, 0, 1, 1],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ],
      solution: 1
    ),
    IslandTestCase(
      map: [
        [1, 1, 0, 1, 1]
      ],
      solution: 2
    ),
    IslandTestCase(
      map: [
        []
      ],
      solution: 0
    ),
    IslandTestCase(
      map: [
        [1, 1, 0, 0, 0],
        [1, 1, 0, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 0, 1, 1]
      ],
      solution: 3
    )
  ]

  private func makeVisitedArray(map: [[Int]]) -> [[Bool]] {
    var visited: [[Bool]] = []

    for row in map {
      var boolRow = [Bool]()

      for _ in row {
        boolRow.append(false)
      }

      visited.append(boolRow)
    }

    return visited
  }

  private func depthFirstSearch(row: Int, col: Int, map: [[Int]]) {
    self.visited[row][col] = true

    // Check the 4 neighbours of a given cell (left, right, up, down).
    // We don't allow Diagonal moves, but we could easily extend this to 8 neighbours.

    // Make sure the row is safe to access.
    if row >= 0 && row < map.count {

      // Get the number of columns in that row.
      let numberOfCols = map[row].count

      // Can we move down.
      if row + 1 < map.count && map[row + 1][col] == 1 && !self.visited[row + 1][col] {
        depthFirstSearch(row: row + 1, col: col, map: map)
      }

      // Can we move up.
      else if row - 1 >= 0 && map[row - 1][col] == 1 && !self.visited[row - 1][col] {
        depthFirstSearch(row: row - 1, col: col, map: map)
      }

      // Can we move left.
      else if col - 1 >= 0 && map[row][col - 1] == 1 && !self.visited[row][col - 1] {
        depthFirstSearch(row: row, col: col - 1, map: map)
      }

      // Can we move right.
      else if col + 1 < numberOfCols && map[row][col + 1] == 1 && !self.visited[row][col + 1] {
        depthFirstSearch(row: row, col: col + 1, map: map)
      }
    }
  }

  private func countIslands(map: [[Int]]) -> Int {
    // Keep track of where we have been so we know where we are going.
    self.visited = self.makeVisitedArray(map: map)

    var islandCount = 0

    for (i, row) in map.enumerated() {
      for (j, colValue) in row.enumerated() {
        if !self.visited[i][j] && colValue == 1 {
          depthFirstSearch(row: i, col: j, map: map)

          // The number of calls to `depthFirstSearch` is the number of islands.
          islandCount += 1
        }
      }
    }

    return islandCount
  }

  func testCountIslands() {
    for (i, testCase) in self.testCases.enumerated() {
      let islandCount = self.countIslands(map: testCase.map)

      XCTAssert(
        islandCount == testCase.solution,
        "Expected \(testCase.solution) islands, but got \(islandCount) for test case \(i)"
      )
    }
  }
}

CountTheIslandsTests.defaultTestSuite.run()

