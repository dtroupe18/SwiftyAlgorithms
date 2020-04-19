
/**
 String to Integer (atoi)

 Implement atoi which converts a string to an integer.

 The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and interprets them as a numerical value.

 The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.

 If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.

 If no valid conversion could be performed, a zero value is returned.

 Note:

 Only the space character ' ' is considered as whitespace character.
 Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. If the numerical value is out of the range of representable values, INT_MAX (231 − 1) or INT_MIN (−231) is returned.


 Example 1:

 Input: "42"
 Output: 42


 Example 2:

 Input: "   -42"
 Output: -42
 Explanation: The first non-whitespace character is '-', which is the minus sign.
 Then take as many numerical digits as possible, which gets 42.


 Example 3:

 Input: "4193 with words"
 Output: 4193
 Explanation: Conversion stops at digit '3' as the next character is not a numerical digit.


 Example 4:

 Input: "words and 987"
 Output: 0
 Explanation: The first non-whitespace character is 'w', which is not a numerical
 digit or a +/- sign. Therefore no valid conversion could be performed.

 Example 5:

 Input: "-91283472332"
 Output: -2147483648
 Explanation: The number "-91283472332" is out of the range of a 32-bit signed integer.
 Thefore INT_MIN (−2^31) is returned.

 */

import Foundation
import XCTest

class StringToInteger: XCTestCase {
  struct TestCase {
    let input: String
    let output: Int
  }

  let testCases: [TestCase] = [
    TestCase(input: "42", output: 42),
    TestCase(input: "-42", output: -42),
    TestCase(input: "4193 with words", output: 4193),
    TestCase(input: "words and 987", output: 0),
    TestCase(input: "-91283472332", output: -2147483648),
    TestCase(input: ".1", output: 0),
    TestCase(input: "  0000000000012345678", output: 12345678),
    TestCase(input: "+-2", output: 0),
    TestCase(input: "    +0a32", output: 0),
    TestCase(input: "-2147483647", output: -2147483647),
    TestCase(input: "1", output: 1),
    TestCase(input: "-2147483648", output: -2147483648)
  ]

  // Runtime: 20 ms, faster than 42.52% of Swift online submissions for String to Integer (atoi).
  // Memory Usage: 21.4 MB, less than 25.00% of Swift online submissions for String to Integer (atoi).
  func myAtoi(_ str: String) -> Int {
    let maxInt = Int32.max
    let minInt = Int32.min
    let chars = Array(str)

    var sign: Int32 = 1
    var digits: [Int32] = []

    var reachedFirstChar = false
    var index = 0

    while index < chars.count {
      if chars[index] != " " {
        if chars[index] == "-" {
          sign = -1
          reachedFirstChar = true
        } else if chars[index] == "+" {
          reachedFirstChar = true
        } else if let intVal = Int32(String(chars[index])) {
          digits.append(intVal)
          reachedFirstChar = true
        } else {
          break // invalid startings with a char.
        }
      }

      index += 1

      if reachedFirstChar { break }
    }

    if !reachedFirstChar { return 0 }


    for i in index..<chars.count {
      if let digit = Int32(String(chars[i])) {
        digits.append(digit)
      } else {
        if digits.isEmpty {
          // invalid sequence
          return 0
        } else {
          // Number ended
          break
        }
      }
    }

    // print(digits)

    var intValue: Int32 = 0
    let base: Int32 = 10
    var baseMultiplier: Int32 = 0

    for i in 0..<digits.count {
      let digit = digits[i]

      if intValue == 0 && digit == 0 { continue } // leading 0's

      if baseMultiplier > 9 {
        // 10 would be 10 billion which is too big for a 32 bit Int.
        return sign > 0 ? Int(maxInt) : Int(minInt)
      }

      if (maxInt / 10) - intValue < 0 {
        // Overflow.
        return sign > 0 ? Int(maxInt) : Int(minInt)
      }

      let amountToAdd = (intValue * base) - intValue + digit

      if maxInt - intValue - amountToAdd < 0 {
        // Overflow.
        return sign > 0 ? Int(maxInt) : Int(minInt)
      }

      intValue += amountToAdd
      baseMultiplier += 1

      // print("amount to add \(amountToAdd)")
      // print("intValue \(intValue)")
    }

    return Int(intValue * sign)
  }


  func test() {
    for (i, testCase) in testCases.enumerated() {
      let output = myAtoi(testCase.input)
      let solution = testCase.output

      XCTAssertEqual(output, solution, "Expected: \(solution) but got: \(output) for testCase: \(i)")
    }
  }
}

StringToInteger.defaultTestSuite.run()
