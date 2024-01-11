/**
 Problem:

 Given a list of positive integers nums and an int target, return indices of the two numbers such that they add up to a target - 30.

 Conditions:

 You will pick exactly 2 numbers.
 You cannot pick the same element twice.
 If you have muliple pairs, select the pair with the largest number.

 Example 1:

 Input: nums = [1, 10, 25, 35, 60], target = 90
 Output: [2, 3]

 Explanation:
 nums[2] + nums[3] = 25 + 35 = 60 = 90 - 30


 Example 2:

 Input: nums = [20, 50, 40, 25, 30, 10], target = 90
 Output: [1, 5]

 Explanation:
 nums[0] + nums[2] = 20 + 40 = 60 = 90 - 30
 nums[1] + nums[5] = 50 + 10 = 60 = 90 - 30

 [Ref](https://leetcode.com/discuss/interview-question/356960)
 */

import Foundation
import XCTest

struct TestCase {
  let numbers: [Int]
  let target: Int
  let solution: [Int]
}

final class TwoSumMediumTests: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(numbers: [1, 10, 25, 35, 60], target: 90, solution: [2, 3]),
    TestCase(numbers: [20, 50, 40, 25, 30, 10], target: 90, solution: [1, 5]),
    TestCase(numbers: [20, 50], target: 90, solution: []),
    TestCase(numbers: [20], target: 90, solution: []),
    TestCase(numbers: [0, 0], target: 30, solution: [0, 1])
  ]

  // Complexity here is O(n) since we only loop over numbers once.
  func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    let target = target - 30

    // Value: Index
    var dict: [Int: Int] = [:]
    var largestNumber: Int = -1 // We can make this -1 because the array only has positive #'s.
    var solution: [Int] = []

    for i in 0..<nums.count {
      let num = nums[i]

      // b = target - a.
      let neededB = target - num

      if let index = dict[neededB] {
        // Index has to be lower since it was added first.
        // We aren't done yet because we need to know if there
        // is a solution with a larger value.

        if neededB > largestNumber {
          largestNumber = neededB
          solution = [index, i]
        } else if num > largestNumber {
          largestNumber = num
          solution = [index, i]
        }
      }

      dict[num] = i
    }

    return solution
  }

  func testTwoSum() {
    for (_, testCase) in testCases.enumerated() {
      let result = twoSum(testCase.numbers, testCase.target)
      let solution = testCase.solution

      XCTAssertEqual(result, solution)
    }
  }
}

TwoSumMediumTests.defaultTestSuite.run()
