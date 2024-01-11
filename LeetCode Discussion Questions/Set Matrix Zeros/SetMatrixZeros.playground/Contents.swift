/**
 Given a m x n matrix, if an element is 0, set its entire row and column to 0. Do it in-place.

 Example 1:

 Input:

 [
 [1,1,1],
 [1,0,1],
 [1,1,1]
 ]

 Output:

 [
 [1,0,1],
 [0,0,0],
 [1,0,1]
 ]


 Example 2:

 Input:

 [
 [0,1,2,0],
 [3,4,5,2],
 [1,3,1,5]
 ]

 Output:
 [
 [0,0,0,0],
 [0,4,5,0],
 [0,3,1,0]
 ]

 Follow up:

 A straight forward solution using O(mn) space is probably a bad idea.
 A simple improvement uses O(m + n) space, but still not the best solution.
 Could you devise a constant space solution?

 [Ref](https://leetcode.com/explore/interview/card/top-interview-questions-medium/103/array-and-strings/777/)
 */

import Foundation
import XCTest

struct TestCase {
  let input: [[Int]]
  let output: [[Int]]
}

class SetMatrixZeros: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(
      input: [
        [1,1,1],
        [1,0,1],
        [1,1,1]
      ],
      output: [
        [1,0,1],
        [0,0,0],
        [1,0,1]
      ]),
    TestCase(
      input: [
        [0,1,2,0],
        [3,4,5,2],
        [1,3,1,5]
      ],
      output: [
        [0,0,0,0],
        [0,4,5,0],
        [0,3,1,0]
      ]
    )
  ]

  func setZeroes(_ matrix: inout [[Int]]) {
    guard !matrix.isEmpty else { return }
    guard !matrix[0].isEmpty else { return }

    let numberOfRows = matrix.count
    let numberOfCols = matrix[0].count

    var rowsToZero = Set<Int>()
    var colsToZero = Set<Int>()

    for i in 0..<numberOfRows {
      for j in 0..<numberOfCols {
        if matrix[i][j] == 0 {
          rowsToZero.insert(i)
          colsToZero.insert(j)
        }
      }
    }

    if rowsToZero.isEmpty && colsToZero.isEmpty {
      return // nothing to do.
    }

    for i in rowsToZero {
      for j in 0..<numberOfCols {
        matrix[i][j] = 0
      }
    }

    for j in colsToZero {
      for i in 0..<numberOfRows {
        matrix[i][j] = 0
      }
    }
  }

  func testSetZeros() {
    for testCase in testCases {
      var matrix = testCase.input
      setZeroes(&matrix)

      XCTAssertEqual(testCase.output, matrix)
    }
  }
}

SetMatrixZeros.defaultTestSuite.run()
