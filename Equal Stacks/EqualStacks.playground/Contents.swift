import Foundation
import XCTest

/**
 Problem - Given three stack of the positive numbers, the task is to find the possible equal maximum sum of the stacks with removal of top elements allowed. Stacks are represented as array, and the first index of the array represent the top element of the stack.
 */

struct TestCase {
  let h1: [Int]
  let h2: [Int]
  let h3: [Int]
  let solution: Int
}

final class EqualStackTests: XCTestCase {
  private var testCases: [TestCase] = [
    TestCase(h1: [3, 10], h2: [4, 5], h3: [2, 1], solution: 0),
    TestCase(h1: [3, 2, 1, 1, 1], h2: [4, 3, 2], h3: [1, 1, 4, 1], solution: 5),
    TestCase(h1: [], h2: [], h3: [], solution: 0),
    TestCase(h1: [10], h2: [10], h3: [10], solution: 10),
    TestCase(h1: [1, 1, 1, 1], h2: [1, 1, 1, 1], h3: [1, 1], solution: 2)
  ]

  /**
   Returns the maximum height of stacks when they are equal.

   Algorithm Process:
      1. Find sum of all elements of in individual stacks.
      2. If the sum of all three stacks is same, then this is the maximum sum.
      3. Else remove the top element of the stack having the maximum sum among three of stacks.
      4. Repeat step 1 and step 2.

      The approach works because elements are positive. To make sum equal, we must remove some element from stack having more sum and we can only remove from top.

   Time Complexity : O(n1 + n2 + n3).
   */
  func equalStacks(h1: [Int], h2: [Int], h3: [Int]) -> Int {
    var height1 = h1.reduce(0, +)
    var height2 = h2.reduce(0, +)
    var height3 = h3.reduce(0, +)

    var heightsEqual: Bool = false
    var index1 = 0
    var index2 = 0
    var index3 = 0

    while(!heightsEqual) {
      // Needs to be or comparision because if two stacks have equal heights we will loop forever.
      // Ex: h1: 7, h2: 7, h3: 5.
      if height1 > height2 || height1 > height3 {
        height1 -= h1[index1]; index1 += 1
      } else if height2 > height1 || height2 > height3 {
        height2 -= h2[index2]; index2 += 1
      } else if height3 > height1 || height3 > height2 {
        height3 -= h3[index3]; index3 += 1
      } else {
        // They are all equal.
        heightsEqual = true
      }
    }

    return height1 // Doesn't matter what height we return.
  }

  func testEqualStacks() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let result = equalStacks(h1: testCase.h1, h2: testCase.h2, h3: testCase.h3)

      XCTAssert(result == solution, "Expected: \(solution) but got: \(result) for testCase \(i)")
    }
  }
}

EqualStackTests.defaultTestSuite.run()
