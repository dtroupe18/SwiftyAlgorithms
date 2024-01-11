/**
 Problem:

 Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

 Example 1:

 Input: "babad"
 Output: "bab"
 Note: "aba" is also a valid answer.


 Example 2:

 Input: "cbbd"
 Output: "bb"

 [Ref](https://leetcode.com/problems/longest-palindromic-substring/)
 */

import Foundation
import XCTest

struct TestCase {
  let s: String
  let solution: String
}

class LongestPalindromicSubstring: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(s: "ccc", solution: "ccc"),
    TestCase(s: "babad", solution: "aba"),
    TestCase(s: "racecar", solution: "racecar"),
    TestCase(s: "bb", solution: "bb")
  ]

  // Runtime: 120 ms, faster than 76.71% of Swift online submissions for Longest Palindromic Substring.
  // Memory Usage: 21.1 MB, less than 100.00% of Swift online submissions for Longest Palindromic Substring.
  func longestPalindrome(_ s: String) -> String {
    guard !s.isEmpty else { return "" } // is whitespace a palindrome
    guard s.count > 1 else { return s }

    let chars = Array(s)
    var start = 0, end = 0

    for i in 0..<chars.count {
      let length = expandFromCenter(chars: chars, lhs: i, rhs: i)
      let length2 = expandFromCenter(chars: chars, lhs: i, rhs: i + 1)

      let maxLength = max(length, length2)
      // print("maxLength: \(maxLength)")

      if maxLength > (end - start) {
        // print("i \(i)")
        start = i - (maxLength - 1) / 2
        end = i + maxLength / 2
      }
    }

    let longestSubstringPalindrome = String(chars[start...end])
    return longestSubstringPalindrome
  }

  func expandFromCenter(chars: [Character], lhs: Int, rhs: Int) -> Int {
    var left = lhs
    var right = rhs

    while left >= 0, right < chars.count, chars[left] == chars[right] {
      // let palindrome = String(chars[left...right])
      // print("left \(left), right: \(right) pal: \(palindrome)")

      left -= 1
      right += 1
    }

    // return the length
    return right - left - 1
  }

  func test() {
    for (i, testCase) in testCases.enumerated() {
      let result = longestPalindrome(testCase.s)
      let solution = testCase.solution

      XCTAssertEqual(result, solution, "Expected: \(solution) but got: \(result) for testCase: \(i)")
    }
  }
}

LongestPalindromicSubstring.defaultTestSuite.run()
