/**
 Problem

 Given a string, find the length of the longest substring without repeating characters.

 Example 1:

 Input: "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.


 Example 2:

 Input: "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.


 Example 3:

 Input: "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
              Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

 [Ref](https://leetcode.com/problems/longest-substring-without-repeating-characters/)
 */

import Foundation
import XCTest

struct TestCase {
  let str: String
  let solution: Int
}

final class LongestSubstringWithoutRepeatingCharactersTest: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(str: "abcabcbb", solution: 3),
    TestCase(str: "bbbbb", solution: 1),
    TestCase(str: "pwwkew", solution: 3),
    TestCase(str: "ABDEFGABEF", solution: 6),
    TestCase(str: "GEEKSFORGEEKS", solution: 7)
  ]

  func lengthOfLongestSubstring(_ s: String) -> Int {
    // character and the last index it was at.
    var previousChars: [Character: Int] = [:]
    let chars = Array(s)
    var currentLength = 0
    var maxLength = 0

    for i in 0..<chars.count {
      let previousIndex = previousChars[chars[i]] ?? -1

      if previousIndex == -1 || i - previousIndex > currentLength {
        currentLength += 1
      } else {
        maxLength = max(currentLength, maxLength)
        currentLength = i - previousIndex
      }

      previousChars[chars[i]] = i
    }

    maxLength = max(currentLength, maxLength)
    return maxLength
  }

  func testLongestSubString() {
    for (i, testCase) in testCases.enumerated() {
      let result = lengthOfLongestSubstring(testCase.str)
      let solution = testCase.solution

      XCTAssertEqual(result, solution, "Expected: \(solution) but got: \(result) for testCase: \(i)")
    }
  }
}

LongestSubstringWithoutRepeatingCharactersTest.defaultTestSuite.run()
