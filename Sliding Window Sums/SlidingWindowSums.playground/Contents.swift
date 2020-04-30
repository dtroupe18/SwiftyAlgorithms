/**
 Problem

 You own a service that allows your customers to report out metrics every 30 seconds.
 One of your customers has a metric that spikes up and down,
 so they have requested that we give them better representations their data.

 Their initial request is to smooth out the data using a sliding window that generates
 the sum of the values in that window.

 Taking their metric data set and a window size, return the result of that sliding window.

 // Example: input = [1,2,3,4,5,6]  size = 3
 // 1 2 3 = 6
 // 2 3 4 = 9
 // 3 4 5 = 12
 // 4 5 6 = 15
 */

import Foundation
import XCTest

struct TestCase {
  let input: [Int]
  let size: Int
  let solution: [Int]
}

final class SlidingWidowSums: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(input: [1, 2, 3, 4, 5, 6], size: 3, solution: [6, 9, 12, 15]),
    TestCase(input: [1, 2, 3, 4, 5, 6], size: 2, solution: [3, 5, 7, 9, 11]),
    TestCase(input: [1, 2, 3, 4, 5, 6], size: 1, solution: [1, 2, 3, 4, 5, 6]),
    TestCase(input: [1, 2, 3, 4, 5, 6], size: 5, solution: [15, 20]),
    TestCase(input: [1, 2, 3, 4, 5, 6], size: 6, solution: [21])
  ]

  func calculateSlidingWindows(_ input: [Int], size: Int) -> [Int] {
      guard input.count >= size else { return [] } // maybe sum this instead.
      guard size > 0 else { return input }

      var partialSums: [Int] = [] // 6, 9,
      var partialSum = 0

      // O(n)
      for i in 0..<input.count {
         if i >= size - 1 {
              partialSum += input[i]
              partialSums.append(partialSum)

              let amountToSubtract = input[i - (size - 1)]
              partialSum -= amountToSubtract
         } else {
              partialSum += input[i]
         }
      }

      return partialSums
  }

  func test() {
    for (i, testCase) in testCases.enumerated() {
      let result = calculateSlidingWindows(testCase.input, size: testCase.size)
      let solution = testCase.solution

      XCTAssertEqual(result, solution, "Expected: \(solution) but got: \(result) for testCase: \(i)")
    }
  }
}

SlidingWidowSums.defaultTestSuite.run()
