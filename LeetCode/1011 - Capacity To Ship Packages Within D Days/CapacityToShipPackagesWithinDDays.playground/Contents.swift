/**
 Problem

 A conveyor belt has packages that must be shipped from one port to another within D days.

 The i-th package on the conveyor belt has a weight of weights[i].
 Each day, we load the ship with packages on the conveyor belt (in the order given by weights).
 We may not load more weight than the maximum weight capacity of the ship.

 Return the least weight capacity of the ship that will result in all the packages on the conveyor belt being shipped within D days.


 Example 1:

 Input: weights = [1,2,3,4,5,6,7,8,9,10], D = 5
 Output: 15

 Explanation:
 A ship capacity of 15 is the minimum to ship all the packages in 5 days like this:
 1st day: 1, 2, 3, 4, 5
 2nd day: 6, 7
 3rd day: 8
 4th day: 9
 5th day: 10

 Note that the cargo must be shipped in the order given, so using a ship of capacity 14 and splitting the packages into parts like (2, 3, 4, 5), (1, 6, 7), (8), (9), (10) is not allowed.


 Example 2:

 Input: weights = [3,2,2,4,1,4], D = 3
 Output: 6

 Explanation:
 A ship capacity of 6 is the minimum to ship all the packages in 3 days like this:
 1st day: 3, 2
 2nd day: 2, 4
 3rd day: 1, 4


 Example 3:

 Input: weights = [1,2,3,1,1], D = 4
 Output: 3

 Explanation:
 1st day: 1
 2nd day: 2
 3rd day: 3
 4th day: 1, 1
 */

import Foundation
import XCTest

struct TestCase {
  let weights: [Int]
  let days: Int
  let solution: Int
}

final class ShipPackagesWithinDDaysTests: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(weights: [1,2,3,1,1], days: 4, solution: 3),
    TestCase(weights: [1,2,3,4,5,6,7,8,9,10], days: 5, solution: 15),
    TestCase(
      weights: [474,465,91,171,362,15,187,270,29,279,283,207,210,246,131,346,500,140,142,420,244,326,99,51,464,241,307,313,98,52,140,296],
      days: 16, solution: 614
    )
  ]

  // Runtime: 2228 ms, faster than 5.26% of Swift online submissions for Capacity To Ship Packages Within D Days.
  // Memory Usage: 21.7 MB, less than 100.00% of Swift online submissions for Capacity To Ship Packages Within D Days.
  // Complexity O(n^3)
  func shipWithinDaysBruteForce(_ weights: [Int], _ D: Int) -> Int {
    guard !weights.isEmpty, D > 0 else { return 0 }

    let days = D
    var totalWeight = 0
    var maxWeight = 0

    for i in 0..<weights.count {
      totalWeight += weights[i]

      if weights[i] > maxWeight {
        maxWeight = weights[i]
      }
    }

    var currentDayWeight: Int = 0
    var numberOfDaysNeeded: Int = 1

    while maxWeight < totalWeight {
      for i in 0..<weights.count {
        if currentDayWeight + weights[i] <= maxWeight {
          currentDayWeight += weights[i]
        } else {

          if numberOfDaysNeeded + 1 > days {
            currentDayWeight = 0
            numberOfDaysNeeded = 1
            maxWeight += 1
            break
          } else {
            numberOfDaysNeeded += 1
            currentDayWeight = weights[i]
          }
        }
      }

      if numberOfDaysNeeded <= days && currentDayWeight != 0 {
        break
      }
    }

    return maxWeight
  }

  /**
   The trick here is to search for a weight that works. We know that the min solution
   would be at least the largest total day value, we also know the max solution is the total weight (take everything at once).

   Since this list of possible solutions [avg...total] is sorted, we can use binary search to
   dramatically speed up this process.

   Runtime: 276 ms, faster than 97.37% of Swift online submissions for Capacity To Ship Packages Within D Days.
   Memory Usage: 21.7 MB, less than 100.00% of Swift online submissions for Capacity To Ship Packages Within D Days.

   Complexity O(n) for the summing loop, then we do O(logD) search operations, then we do another loop O(n). So O(n^2 * logD).
   */
  func shipWithinDays(_ weights: [Int], _ D: Int) -> Int {
    guard !weights.isEmpty, D > 0 else { return 0 }

    let days = D
    var high: Int = 0
    var low: Int = weights[0] // set to the largest single weight.

    for i in 0..<weights.count {
      low = max(low, weights[i])
      high += weights[i]
    }

    while low < high {
      let middle: Int = (low + high) / 2

      if canShipWith(weights: weights, days: days, maxWeight: middle) {
        high = middle
      } else {
        low = middle + 1
      }
    }

    return low
  }

  func canShipWith(weights: [Int], days: Int, maxWeight: Int) -> Bool {
    var currentDaysWeight: Int = 0
    var numberOfDays: Int = 1 // It has to take at least 1 day.

    for i in 0..<weights.count {
      if currentDaysWeight + weights[i] > maxWeight {
        currentDaysWeight = 0
        numberOfDays += 1

        if numberOfDays > days { return false }
      }

      currentDaysWeight += weights[i]
    }

    return numberOfDays <= days
  }

  func testShipWithinDaysBruteForce() {
    for testCase in testCases {
      let result = shipWithinDaysBruteForce(testCase.weights, testCase.days)

      XCTAssertEqual(result, testCase.solution)
    }
  }

  func testShipWithinDaysBinarySearch() {
    for testCase in testCases {
      let result = shipWithinDays(testCase.weights, testCase.days)

      XCTAssertEqual(result, testCase.solution)
    }
  }
}

ShipPackagesWithinDDaysTests.defaultTestSuite.run()
