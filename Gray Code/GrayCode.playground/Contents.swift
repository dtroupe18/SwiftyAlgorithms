/**
 For a given n, a gray code sequence may not be uniquely defined.
 For example, [0,2,3,1] is also a valid gray code sequence.

 00 - 0
 10 - 2
 11 - 3
 01 - 1

 Example 2:

 Input: 0
 Output: [0]

 Explanation:

 We define the gray code sequence to begin with 0.
 A gray code sequence of n has size = 2n, which for n = 0 the size is 20 = 1.
 Therefore, for n = 0 the gray code sequence is [0].
 */

import Foundation
import XCTest

struct TestCase {
  let input: Int
  let solution: [Int]
}

class GrayCode: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(input: 2, solution: [0, 1, 3, 2]),
    TestCase(input: 3, solution: [0, 1, 3, 2, 6, 7, 5, 4])
  ]

  /**
   Algorithm:

   For 0 we always return 0.
   For 1 we have to return 0 first so we can only return 0, 1.

   For every other non trivial case we start with [0, 1] and we iterate over it in
   reverse n - 1 times adding the same bit shift to each number to get the next number.

   Example n = 2

   restults = [0, 1]

   We take 1 and we add `(1<<i)` i in 1 in this case so we get 10 as our bit shift for this loop.
   1 in binary is 01 so we get 01 + 10 = 11 or (3) which is a one bit shift.

   Next we get 0 and we add the same 10 shift. 0 in binary is 00 so 00 + 10 = 10 or 2.

   Because 0 and 1 were only 1 bit appart to start adding the same shift to them will also result in
   two values that are only 1 bit apart.

   Runtime: 8 ms, faster than 95.65% of Swift online submissions for Gray Code.
   Memory Usage: 21.1 MB, less than 100.00% of Swift online submissions for Gray Code.
   */
  func grayCode(_ n: Int) -> [Int] {
    if n == 0 { return [0] }
    if n == 1 { return [0, 1]}

    var result: [Int] = [0, 1]

    for i in 1..<n {
      var res: [Int] = []

      for val in result.reversed() {
        let x = val + (1<<i)
        // print("val: \(val) x: \(x)")
        res.append(x)
      }

      result += res
      // print("result: \(result)")
    }

    return result
  }

  func testGrayCode() {
    for (i, testCase) in testCases.enumerated() {
      let result = grayCode(testCase.input)

      XCTAssertEqual(result, testCase.solution, "Expected: \(testCase.solution), but got \(result) for test case: \(i)")
    }
  }
}

GrayCode.defaultTestSuite.run()
