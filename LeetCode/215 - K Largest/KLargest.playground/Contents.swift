import Foundation
import XCTest

struct TestCase {
  let array: [Int]
  let k: Int
  let solution: [Int]
}

/**
 Problem: Write an efficient program for printing k largest elements in an array.
 Elements in array can be in any order. For example, if given array is
 [1, 23, 12, 9, 30, 2, 50] and you are asked for the largest 3 elements
 i.e., k = 3 then your program should print 50, 30 and 23.
 */

final class KLargestTests: XCTestCase {
  private let testCases: [TestCase] = [
    TestCase(array: [1, 23, 12, 9, 30, 2, 50], k: 3, solution: [50, 30, 23])
  ]

  private func makeLargeTestCases(numberOfCases: Int, arraySize: Int, k: Int) -> [TestCase] {
    var testCases: [TestCase] = []

    for _ in 0..<numberOfCases {
      var array: [Int] = []

      for j in 1...arraySize {
        array.append(j)
      }

      array.shuffle()

      var solutions: [Int] = []

      for j in 0..<k {
        solutions.append(arraySize - j)
      }

      testCases.append(TestCase(array: array, k: k, solution: solutions))
    }

    return testCases
  }

  /**
   Algorithm Process:
    1. Initialize an array (largest) to store the k largest numbers in largest to smallest order.
    2. Insert the first element of the test array into this array (largest).
    3. Loop over the remainder of the test array O(n).
    4. For each element we compare it starting at the end of largest (smallest largest value).
       If the current element is larger than the smallest largest element, keep going until we find
       a value it's not greater than and insert it there. O(k).

    Time Complexity: O(n*k)
   */
  private func findLargest(array: [Int], k: Int) -> [Int] {
    assert(array.count > k)

    var largest: [Int] = []
    largest.append(array[0])

    // Take the first k elements and make them the largest. We
    // Want this to be ordered High -> low so we can compare.
    for i in 1..<array.count {
      let value = array[i]

      for j in (0..<largest.count).reversed() {
        let largeValue = largest[j]

        if value > largeValue {

          // Check if it's greater than the next value.
          if j - 1 >= 0 && value > largest[j - 1] {
            // Don't insert yet because it's bigger than the next number too.
            continue
          } else {
            // We are at the first index or it's not greater than the next element.
            largest.insert(value, at: j)

            if largest.count > k {
              // Keep this limited the k elements for efficiency.
              largest.remove(at: largest.count - 1)
            }
          }
        }
      }
    }

    return largest
  }

  /**
   In this method we first sort the array O(nlogn) then we
   return k elements. O(k). This method will be faster if k > logn.

   Think of the worst case example: Given an array of length n, and k = n
   then the solution requires us to sort the entire array. The above method
   would work out to be O(n^2) which is significantly slower.
   */
  func findLargestBySorting(array: [Int], k: Int) -> [Int] {
    assert(array.count > k)

    let sorted = array.sorted(by: { $0 > $1 })
    var largest: [Int] = []

    for i in 0..<k {
      largest.append(sorted[i])
    }

    return largest
  }

  func testFindLargest() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let largest = findLargest(array: testCase.array, k: testCase.k)

      XCTAssert(largest == solution, "Expected: \(solution) but got: \(largest) for testCase \(i)")
    }

    let largeTestCases = self.makeLargeTestCases(numberOfCases: 2, arraySize: 1000, k: 5)
    for (i, testCase) in largeTestCases.enumerated() {
      let solution = testCase.solution
      let largest = findLargest(array: testCase.array, k: testCase.k)

      XCTAssert(largest == solution, "Expected: \(solution) but got: \(largest) for testCase \(i)")
    }
  }

  func testFindLargestBySorting() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let largest = findLargestBySorting(array: testCase.array, k: testCase.k)

      XCTAssert(largest == solution, "Expected: \(solution) but got: \(largest) for testCase \(i)")
    }

    let largeTestCases = self.makeLargeTestCases(numberOfCases: 2, arraySize: 1000, k: 5)
    for (i, testCase) in largeTestCases.enumerated() {
      let solution = testCase.solution
      let largest = findLargestBySorting(array: testCase.array, k: testCase.k)

      XCTAssert(largest == solution, "Expected: \(solution) but got: \(largest) for testCase \(i)")
    }
  }

  func testFindLargestPerformance() {
    // measured [Time, seconds] average: 0.198
    // relative standard deviation: 41.933%
    // values: [0.446819, 0.174715, 0.165422, 0.172152, 0.169867, 0.171557, 0.173765, 0.166912, 0.166346, 0.172010]
    guard let largeTestCase = self.makeLargeTestCases(numberOfCases: 1, arraySize: 2000, k: 100).first else {
      XCTFail("Failed to create large test case")
      return
    }

    measure {
      _ = findLargest(array: largeTestCase.array, k: largeTestCase.k)
    }
  }

  func testFindLargestBySortingPerformance() {
    // measured [Time, seconds] average: 0.029
    // relative standard deviation: 4.569%
    // values: [0.032741, 0.029056, 0.029607, 0.027267, 0.028833, 0.029656, 0.029598, 0.029800, 0.028640, 0.028414]

    guard let largeTestCase = self.makeLargeTestCases(numberOfCases: 1, arraySize: 2000, k: 100).first else {
      XCTFail("Failed to create large test case")
      return
    }

    measure {
      _ = findLargestBySorting(array: largeTestCase.array, k: largeTestCase.k)
    }
  }
}

KLargestTests.defaultTestSuite.run()
