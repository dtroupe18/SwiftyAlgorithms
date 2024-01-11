import XCTest

final class Solution: XCTestCase {
  private struct TestCase {
    let input: Int
    let output: Bool
  }

  private let testCases: [TestCase] = [
    TestCase(input: 121, output: true),
    TestCase(input: -121, output: false),
    TestCase(input: 10, output: false)
  ]

  /*
   Runtime: 68 ms, faster than 28.47% of Swift online submissions for Palindrome Number.
   Memory Usage: 14.6 MB, less than 76.82% of Swift online submissions for Palindrome Number.
   */
  func isPalindrome(_ x: Int) -> Bool {
    guard x != 0 else { return true }
    guard x > 0 else { return false } // negatives are never a palindrome.
    guard x > 9 else { return true } // single digit #

    var mutableX = x
    var digits: [Int] = []

    while mutableX > 0 {
      digits.append(mutableX % 10)
      mutableX /= 10
    }

    var reversedX: Int = 0
    var factor: Int = 1

    for digit in digits.reversed() {
      reversedX += factor * digit
      factor *= 10
    }

    return x == reversedX
  }

  func testIsPalindrome() {
    for (index, testCase) in testCases.enumerated() {
      let result = isPalindrome(testCase.input)
      XCTAssertEqual(testCase.output, result, "Expected \(testCase.output), but got \(result) for case \(index)")
    }
  }
}

Solution.defaultTestSuite.run()
