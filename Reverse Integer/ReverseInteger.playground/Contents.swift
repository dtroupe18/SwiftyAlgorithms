/**
 Problem:

 Given a 32-bit signed integer, reverse digits of an integer.

 Example 1:

 Input: 123
 Output: 321
 Example 2:

 Input: -123
 Output: -321
 Example 3:

 Input: 120
 Output: 21

 Note:
 Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.

 [Ref](https://leetcode.com/problems/reverse-integer/)
 */

import Foundation
import XCTest

struct TestCase {
  let x: Int
  let solution: Int
}

class ReverseNumber: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(x: 123, solution: 321),
    TestCase(x: 120, solution: 21),
    TestCase(x: 1534236469, solution: 0),
    TestCase(x: -2147483412, solution: -2143847412),
    TestCase(x: -2147483648, solution: 0)
  ]

  func reverse(_ x: Int) -> Int {
    guard x % 10 != x else { return x }

    let sign: Int32 = x < 0 ? -1: 1
    var digits: [Int32] = []

    // Overflow.
    if x < -1 * Int32.max {
      return 0
    }

    var remainingNumber = Int32(x) * sign

    while remainingNumber > 0 {
      digits.append(Int32(remainingNumber % 10))
      remainingNumber /= 10
    }

    // print(digits)

    var reversedNumber: Int32 = 0
    var reverseBase: Int32 = 1

    for i in (0..<digits.count).reversed() {

      // overflow
      if digits[i] > 0, (Int32.max / digits[i]) - reverseBase  <= 0 {
        return 0
      }

      let newAmount: Int32 = digits[i] * reverseBase

      if Int32.max - newAmount < reversedNumber {
        return 0
      }

      // print(newAmount)
      reversedNumber += newAmount

      if Int32.max / 10 - reverseBase < 0 {
        if i == 0 {
          break
        } else {
          return 0
        }
      }
      reverseBase *= 10
    }

    return Int(reversedNumber * sign)
  }

  func test() {
    for testCase in testCases {
      let result = reverse(testCase.x)
      XCTAssertEqual(result, testCase.solution)
    }
  }
}

ReverseNumber.defaultTestSuite.run()
