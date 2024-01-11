/**
 Problem

 Given an array of non-negative integers, you are initially positioned at the first index of the array.

 Each element in the array represents your maximum jump length at that position.

 Determine if you are able to reach the last index.

 Example 1:

 Input: [2,3,1,1,4]
 Output: true

 Explanation:
 Jump 1 step from index 0 to 1, then 3 steps to the last index.


 Example 2:

 Input: [3,2,1,0,4]
 Output: false

 Explanation:

 You will always arrive at index 3 no matter what. Its maximum
 jump length is 0, which makes it impossible to reach the last index.

 [Ref](https://leetcode.com/problems/jump-game/)
 */

import Foundation
import XCTest

struct TestCase {
  let nums: [Int]
  let solution: Bool
}

class JumpGame: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(nums: [0], solution: true),
    TestCase(nums: [0, 0], solution: false),
    TestCase(nums: [2, 3, 1, 1, 4], solution: true),
    TestCase(nums: [3, 2, 1, 0, 4], solution: false)
  ]

  // Runtime: 76 ms, faster than 31.37% of Swift online submissions for Jump Game.
  // Memory Usage: 21.2 MB, less than 100.00% of Swift online submissions for Jump Game.
  //
  // This problem seems more complicated than it really is starting at the first index
  // we update maxIndex to the furthest index we could jump to. We then move on to the next index
  // if it's not possible for us to get there i > maxIndex we return false. Otherwise we continue
  // if the loop completes we are done.
  func canJump(_ nums: [Int]) -> Bool {
    if nums.isEmpty { return false }
    if nums.count == 1 { return true }
    if nums[0] == 0 { return false }

    var maxIndex: Int = 0

    for (i, num) in nums.enumerated() {
      if i > maxIndex {
        // Unreachable, no previous index allowed us to jump here.
        return false
      }

      maxIndex = max(maxIndex, i + num)
    }

    return true
  }

  func testCanJump() {
    for testCase in testCases {
      let result = canJump(testCase.nums)

      XCTAssertEqual(result, testCase.solution, "Expected \(testCase.solution), but got \(result) for testCase \(testCase.nums)")
    }
  }
}

JumpGame.defaultTestSuite.run()
