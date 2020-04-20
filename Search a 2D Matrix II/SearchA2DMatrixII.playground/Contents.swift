/**
 Problem:

 Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:

 Integers in each row are sorted in ascending from left to right.
 Integers in each column are sorted in ascending from top to bottom.
 Example:

 Consider the following matrix:

 [
   [1,   4,  7, 11, 15],
   [2,   5,  8, 12, 19],
   [3,   6,  9, 16, 22],
   [10, 13, 14, 17, 24],
   [18, 21, 23, 26, 30]
 ]
 Given target = 5, return true.

 Given target = 20, return false.

 [Ref](https://leetcode.com/problems/search-a-2d-matrix-ii/)
 */

import Foundation
import XCTest

struct TestCase {
  let matrix: [[Int]]
  let target: Int
  let hasValue: Bool
}

class SearchA2DMatrix: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(
      matrix: [
        [-1],
        [-1]
      ],
      target: 3,
      hasValue: false
    ),
    TestCase(
      matrix: [
        [1,   4,  7, 11, 15],
        [2,   5,  8, 12, 19],
        [3,   6,  9, 16, 22],
        [10, 13, 14, 17, 24],
        [18, 21, 23, 26, 30]
      ],
      target: 3,
      hasValue: true
    ),
    TestCase(
      matrix: [
        [1,   4,  7, 11, 15],
        [2,   5,  8, 12, 19],
        [3,   6,  9, 16, 22],
        [10, 13, 14, 17, 24],
        [18, 21, 23, 26, 30]
      ],
      target: 7,
      hasValue: true
    ),
    TestCase(
      matrix: [
        [1,   4,  7, 11, 15],
        [2,   5,  8, 12, 19],
        [3,   6,  9, 16, 22],
        [10, 13, 14, 17, 24],
        [18, 21, 23, 26, 30]
      ],
      target: 5,
      hasValue: true
    ),
    TestCase(
      matrix: [
        [1,   4,  7, 11, 15],
        [2,   5,  8, 12, 19],
        [3,   6,  9, 16, 22],
        [10, 13, 14, 17, 24],
        [18, 21, 23, 26, 30]
      ],
      target: 20,
      hasValue: false
    )
  ]

  /**
   Start at the bottom left corner and do the following

   If that value is greater than the target we move up a row. We can do this because all of the values
   to the right are larger so the target cannot be in that row.

   If the value is less than the taget we move right a column. Since the row is sorted the target must
   be to the right.

   Example:

   [
     [1,   4,  7, 11, 15],
     [2,   5,  8, 12, 19],
     [3,   6,  9, 16, 22],
     [10, 13, 14, 17, 24],
     [18, 21, 23, 26, 30]
   ]

   Target = 7

   First we pick array[4][0] (18) which is larger than 7 so we move up a row.
   Second we pick array[3][0] (10) which is larger than 7 so we move up a row.
   Third we pick array[2][0] (3) which is smaller than 7 so we move right a column.
   Fourth we pick array[2][1] (6) which is smaller than 7 so we move right a column.
   Fifth we pick array[2][2] (9) which is larger than 7 so we move up a row.
   Sixth we pick array[1][2] (8) which is larger than 7 so we move up a row.
   Seventh we pick array[0][2] (7) which is the target so we return true.


   Runtime: 296 ms, faster than 99.15% of Swift online submissions for Search a 2D Matrix II.
   Memory Usage: 21 MB, less than 25.00% of Swift online submissions for Search a 2D Matrix II.
   */
  func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard matrix.count > 0, matrix[0].count > 0 else { return false }

    let rowCount = matrix.count
    let colCount = matrix[0].count

    guard target >= matrix[0][0] && target <= matrix[rowCount - 1][colCount - 1] else {
      return false
    }

    var i = rowCount - 1
    var j = 0

    // print("\n\n")

    while i >= 0, j < colCount {
      let value = matrix[i][j]

      // print("value: \(value) target: \(target)")

      if value == target {
        return true
      } else if value > target {
        i -= 1 // move up a row
      } else {
        // value < target
        j += 1 // move over a column
      }
    }

    return false
  }

  func test() {
    for (i, testCase) in testCases.enumerated() {
      let result = searchMatrix(testCase.matrix, testCase.target)

      XCTAssertEqual(result, testCase.hasValue, "Expected \(testCase.hasValue), but got \(result) for test case \(i)")
    }
  }
}

SearchA2DMatrix.defaultTestSuite.run()
