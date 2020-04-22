/**
 Problem

 Count the number of prime numbers less than a non-negative number, n.

 Example:

 Input: 10
 Output: 4
 Explanation: There are 4 prime numbers less than 10, they are 2, 3, 5, 7.

 Some prime numbers:

 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73,
 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163,
 167, 173, 179, 181, 191, 193, 197, 199, ...

 [Ref](https://leetcode.com/problems/count-primes/)
 */

import Foundation
import XCTest

struct TestCase {
  let n: Int
  let solution: Int
}

class CountPrimes: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(n: 10, solution: 4),
    TestCase(n: 37, solution: 11),
    TestCase(n: 38, solution: 12)
  ]

  // Complexity O(n) for the initial loop + O(sqrt(n)) for each number
  // so we get O(n * sqrt(n))
  func countPrimes(_ n: Int) -> Int {
    // Logic loop over all of the odd numbers from
    // 3...n, check if each one is prime and if it is increment a count.
    if n <= 2 { return 0 }

    var primeCount: Int = 1 // 1 because we start at 2

    for i in 2..<n {
      if isPrime(i) {
        primeCount += 1
      }
    }

    return primeCount
  }

  // Helper function
  // O(sqrt(n))
  func isPrime(_ x: Int) -> Bool {
    guard x % 2 == 1 else { return false }

    var low = 3
    let sqrt = Double(x).squareRoot()
    let high = Int(sqrt)

    if Double(Int(sqrt)) == sqrt { return false } // perfect square.

    while low <= high {
      if x % low == 0 { return false }
      low += 2 // we don't have to check even factors since 2 wasn't a factor?
    }

    return true // We didn't find any factors.
  }

  func testCountPrimes() {
    for (i, testCase) in testCases.enumerated() {
      let result = countPrimes(testCase.n)
      let solution = testCase.solution

      XCTAssertEqual(result, solution, "Expected \(solution), but got \(result) for test case \(i)")
    }
  }
}

CountPrimes.defaultTestSuite.run()
