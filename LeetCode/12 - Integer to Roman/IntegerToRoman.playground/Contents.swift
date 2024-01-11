/**
 Problem

 Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

 Symbol       Value
 I             1
 V             5
 X             10
 L             50
 C             100
 D             500
 M             1000

 For example, two is written as II in Roman numeral, just two one's added together. Twelve is written as, XII, which is simply X + II. The number twenty seven is written as XXVII, which is XX + V + II.

 Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

 I can be placed before V (5) and X (10) to make 4 and 9.
 X can be placed before L (50) and C (100) to make 40 and 90.
 C can be placed before D (500) and M (1000) to make 400 and 900.
 Given an integer, convert it to a roman numeral. Input is guaranteed to be within the range from 1 to 3999.

 Example 1:

 Input: 3
 Output: "III"


 Example 2:

 Input: 4
 Output: "IV"


 Example 3:

 Input: 9
 Output: "IX"


 Example 4:

 Input: 58
 Output: "LVIII"
 Explanation: L = 50, V = 5, III = 3.


 Example 5:

 Input: 1994
 Output: "MCMXCIV"
 Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.

 [Ref](https://leetcode.com/problems/integer-to-roman/)
 */

import XCTest
import Foundation

struct TestCase {
  let input: Int
  let output: String
}

class IntegerToRoman: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(input: 3, output: "III"),
    TestCase(input: 4, output: "IV"),
    TestCase(input: 9, output: "IX"),
    TestCase(input: 58, output: "LVIII"),
    TestCase(input: 1994, output: "MCMXCIV")
  ]

  // Runtime: 40 ms, faster than 49.73% of Swift online submissions for Integer to Roman.
  // Memory Usage: 20.6 MB, less than 100.00% of Swift online submissions for Integer to Roman.
  func intToRoman(_ num: Int) -> String {
    guard num > 0, num < 4000 else { return "" }

    var num = num // get a mutable copy
    var str: String = ""

    while num > 0 {
      if num >= 1000 {
        // Don't have to worry about 4k
        str += "M"
        num -= 1000
      } else if num >= 900 {
        str += "CM"
        num -= 900
      } else if num >= 500 {
        str += "D"
        num -= 500
      } else if num >= 400 {
        str += "CD"
        num -= 400
      } else if num >= 100 {
        str += "C"
        num -= 100
      } else if num >= 90 {
        str += "XC"
        num -= 90
      } else if num >= 50 {
        str += "L"
        num -= 50
      } else if num >= 40 {
        str += "XL"
        num -= 40
      } else if num >= 10 {
        str += "X"
        num -= 10
      } else if num >= 9 {
        str += "IX"
        num -= 9
      } else if num >= 5 {
        str += "V"
        num -= 5
      } else if num == 4 {
        str += "IV"
        num -= 4
      } else if num == 3 {
        str += "III"
        num -= 3
      } else if num == 2 {
        str += "II"
        num -= 2
      } else {
        str += "I"
        num -= 1
      }
    }

    return str
  }

  func test() {
    for testCase in testCases {
      let output = intToRoman(testCase.input)
      XCTAssertEqual(testCase.output, output)
    }
  }
}

IntegerToRoman.defaultTestSuite.run()
