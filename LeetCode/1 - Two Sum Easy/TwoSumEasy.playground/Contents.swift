/**
 Problem:

 Given an array of integers, return indices of the two numbers such that they add up to a specific target.

 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 Example:

 Given nums = [2, 7, 11, 15], target = 9,

 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].

 [Ref](https://leetcode.com/problems/two-sum/)
 */

import Foundation
import XCTest

struct TestCase {
  let numbers: [Int]
  let target: Int
  let solution: [Int]
}

final class TwoSumTests: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(numbers: [2, 7, 11, 15], target: 9, solution: [0, 1]),
    TestCase(numbers: [3, 2, 4], target: 6, solution: [1, 2])
  ]

  // Runtime: 472 ms, faster than 22.89% of Swift online submissions for Two Sum.
  // Memory Usage: 20.8 MB, less than 5.88% of Swift online submissions for Two Sum.
  // Complexity O(n * n - 1).
  func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    // Key fact from problem statement "You may assume that each input would have exactly one solution"
    // so as soon as we find a solution we can stop.
    // a + b = target.

    for i in 0..<nums.count {
      // Start at the next index so we don't return the same index.
      for j in i + 1..<nums.count {
        if nums[i] + nums[j] == target {
          return [i, j]
        }
      }
    }

    return []
  }

  // Runtime: 32 ms, faster than 92.71% of Swift online submissions for Two Sum.
  // Memory Usage: 21 MB, less than 5.88% of Swift online submissions for Two Sum.
  // Complexity O(n).
  func twoSumDict(_ nums: [Int], _ target: Int) -> [Int] {
    // Value: Index
    var dict: [Int: Int] = [:]

    for i in 0..<nums.count {
      let num = nums[i]

      // b = target - a.
      let neededB = target - num

      if let index = dict[neededB] {
        // Index has to be lower since it was added first.
        return [index, i]
      }

      dict[num] = i
    }

    return []
  }

  func testTwoSum() {
    for (_, testCase) in testCases.enumerated() {
      let result = twoSum(testCase.numbers, testCase.target)
      let solution = testCase.solution

      XCTAssertEqual(result, solution)
    }
  }

  func testTwoSumDict() {
    for (_, testCase) in testCases.enumerated() {
      let result = twoSumDict(testCase.numbers, testCase.target)
      let solution = testCase.solution

      XCTAssertEqual(result, solution)
    }
  }
}

TwoSumTests.defaultTestSuite.run()
