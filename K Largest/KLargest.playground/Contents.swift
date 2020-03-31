import Foundation
import XCTest

struct TestCase {
  let array: [Int]
  let k: Int
  let solution: [Int]
}

final class KLargestTests: XCTestCase {
  private let testCases: [TestCase] = [
    TestCase(array: [1, 23, 12, 9, 30, 2, 50], k: 3, solution: [50, 30, 23])
  ]

  /**
   Problem: Write an efficient program for printing k largest elements in an array.
            Elements in array can be in any order. For example, if given array is
            [1, 23, 12, 9, 30, 2, 50] and you are asked for the largest 3 elements
            i.e., k = 3 then your program should print 50, 30 and 23.

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
    guard array.count != k else { return array }

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

  func testFindLargest() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let largest = findLargest(array: testCase.array, k: testCase.k)

      XCTAssert(largest == solution, "Expected: \(solution) but got: \(largest) for testCase \(i)")
    }
  }
}

KLargestTests.defaultTestSuite.run()
