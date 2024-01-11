import Foundation
import XCTest

struct TestCase {
  let numbers: [Int]
  let k: Int
  let solution: Int
}

final class KDiffTests: XCTestCase {
  private let testCases: [TestCase] = [
    // (1, 3) and (3, 5).
    TestCase(numbers: [3, 1, 4, 1, 5], k: 2, solution: 2),

    // (1, 2), (2, 3), (3, 4) and (4, 5).
    TestCase(numbers: [1, 2, 3, 4, 5], k: 1, solution: 4),

    // (1, 1).
    TestCase(numbers: [1, 3, 1, 5, 4], k: 0, solution: 1),

    // (1, 4) and (5, 2).
    TestCase(numbers: [1, 5, 3, 4, 2], k: 3, solution: 2),

    // (0, 4), (4, 8), (8, 12), (12, 16) and (16, 20).
    TestCase(numbers: [8, 12, 16, 4, 0, 20], k: 4, solution: 5)
  ]

  private func makeLargeTestCase() -> TestCase {
    // This is used for performance testing only. Since this array is always different we have
    // to calculate the solution using a method before we can create the test case.
    let largeArray = self.makeRandomIntArray(length: 1000, minValue: 0, maxValue: 1000)
    let k = Int.random(in: 1 ... 37)
    let solution = findPairsUsingDictionary(numbers: largeArray, k: k)

    return TestCase(numbers: largeArray, k: k, solution: solution)
  }

  private func makeRandomIntArray(length: Int, minValue: Int, maxValue: Int) -> [Int] {
    return (0..<length).map{ _ in Int.random(in: minValue ... maxValue) }
  }

  /**
   Returns the k-diff pair count by using nested for loops.
   - Parameter k: defines the absolute difference |x − y|.
   - Note: This method has O(n^2) complexity.
   */
  private func findPairsUsingForLoops(numbers: [Int], k: Int) -> Int {
    // Absolute difference |x − y| ≥ 0, since absolute value is always non-negative.
    guard !(k < 0) else { return 0 }

    // Conform to Hashable so we can use this as a dictionary key.
    struct Pair: Hashable, CustomStringConvertible {
      let first: Int
      let second: Int

      var description: String {
        return "(\(first), \(second))"
      }

      func hash(into hasher: inout Hasher) {
        hasher.combine(first)
        hasher.combine(second)
      }

      static func ==(lhs: Pair, rhs: Pair) -> Bool {
        return lhs.first == rhs.first && lhs.second == rhs.second
      }
    }

    var pairs: [Pair: Int] = [:]

    // Algorithm Process
    //
    // This process is very simple we start with the first number and calculate its
    // difference with every other number. Then we move to the next number
    // and do the same thing. We store the pairs in a dictionary as keys so we can maintain
    // the number of UNIQUE pairs.

    for i in 0..<numbers.count {
      // Numbers don't have to be unique so we have to avoid repeated pairs
      // like the 3, 1 in the first case.

      for j in i + 1..<numbers.count {
        if abs(numbers[i] - numbers[j]) == k {
          // We have to worry about order here (3, 1) has to be the same as (1, 3).
          let lower = numbers[i] < numbers[j] ? numbers[i] : numbers[j]
          let higher = numbers[i] > numbers[j] ? numbers[i] : numbers[j]

          let pair = Pair(first: lower, second: higher)
          pairs[pair, default: 0] += 1
        }
      }
    }

    return pairs.count
  }

  /**
   Returns the k-diff pair count by using sort and binary search.
   - Parameter k: defines the absolute difference |x − y|.
   - Note: This method has O(nLogn) complexity.
   - Note: Default sorting algorithm in Swift is IntroSort.
   */
  private func findPairsUsingSort(numbers: [Int], k: Int) -> Int {
    guard !(k < 0) else { return 0 }

    // Algorithm Process
    //
    // [1] Sort the array and remove duplicates.
    // [2] Search for array[i] + k in subarray array[i + 1...]. If this number
    //     exists then we increment the pair count.

    let sortedSet = Set(numbers).sorted()

    guard k != 0 else {
      // Only duplicates have an absolute difference of 0.
      return numbers.count - sortedSet.count
    }

    var pairCount: Int = 0

    for i in 0..<sortedSet.count - 1 {
      let remainingValues = sortedSet[(i + 1)...]
      if remainingValues.contains(sortedSet[i] + k) {
        pairCount += 1
      }
    }

    return pairCount
  }

  /**
   Returns the k-diff pair count by using a Dictionary (HashMap).
   - Parameter k: defines the absolute difference |x − y|.
   - Note: This method has O(n) complexity.

   */
  private func findPairsUsingDictionary(numbers: [Int], k: Int) -> Int {
    guard !(k < 0) else { return 0 }

    // Algorithm Process
    //
    // [1] - Add all numbers to the dictionary as keys and their frequencies as the values.
    // [2] - Loop over the dictionaries values and check the following:
    //
    //   [2.1] - If k = 0, we are looking for the keys with a frequency > 1. Since
    //           absolute difference will be 0 if and only if x = y for |x - y| == 0.
    //
    //   [2.2] - If k != 0, we are checking to see if dict[key + k] exists. This works
    //           because if dict[key + k] = y then the pair (key, y) has absolute diff k.

    var pairCount: Int = 0
    var dict: [Int: Int] = [:]

    // [1]
    for number in numbers {
      // dict[number] = dict[number] == nil ? 0 : dict[number]! + 1
      dict[number, default: 0] += 1
    }

    // [2]
    for (number, count) in dict {

      // [2.1]
      if k == 0 {
        if count > 1 {
          pairCount += 1
        }

        // [2.2]
      } else if dict[number + k] != nil {
        pairCount += 1
      }
    }

    return pairCount
  }

  func testPairCountDictMethod() {
    for (i, testCase) in testCases.enumerated() {
      let pairCount = findPairsUsingDictionary(numbers: testCase.numbers, k: testCase.k)

      XCTAssert(
        pairCount == testCase.solution,
        "Expected \(testCase.solution) pairs, but got \(pairCount) for test case \(i)"
      )
    }
  }

  func testPairCountLoopMethod() {
    for (i, testCase) in testCases.enumerated() {
      let pairCount = findPairsUsingForLoops(numbers: testCase.numbers, k: testCase.k)

      XCTAssert(
        pairCount == testCase.solution,
        "Expected \(testCase.solution) pairs, but got \(pairCount) for test case \(i)"
      )
    }
  }

  func testPairCountSortMethod() {
    for (i, testCase) in testCases.enumerated() {
      let pairCount = findPairsUsingSort(numbers: testCase.numbers, k: testCase.k)

      XCTAssert(
        pairCount == testCase.solution,
        "Expected \(testCase.solution) pairs, but got \(pairCount) for test case \(i)"
      )
    }
  }

  // MARK: Performance

  func testPerformanceForLoop() {
    let testCase = self.makeLargeTestCase()
    measure {
      // measured [Time, seconds] average: 1.739,
      // relative standard deviation: 4.723%,
      // values: [1.616935, 1.779473, 1.745428, 1.724857, 1.826358, 1.725243, 1.755367, 1.571012, 1.824115, 1.823446]
      let pairCount = findPairsUsingForLoops(numbers: testCase.numbers, k: testCase.k)

      XCTAssert(
        pairCount == testCase.solution,
        "Expected \(testCase.solution) pairs, but got \(pairCount) for large test case."
      )
    }
  }

  func testPerformanceForSort() {
    let testCase = self.makeLargeTestCase()
    measure {
      // measured [Time, seconds] average: 1.011
      // relative standard deviation: 6.452%,
      // values: [0.911551, 0.934729, 0.954507, 0.969094, 1.083831, 1.072562, 1.100220, 1.056208, 1.049508, 0.975055]
      let pairCount = findPairsUsingSort(numbers: testCase.numbers, k: testCase.k)

      XCTAssert(
        pairCount == testCase.solution,
        "Expected \(testCase.solution) pairs, but got \(pairCount) for large test case."
      )
    }
  }

  func testPerformanceForDict() {
    let testCase = self.makeLargeTestCase()
    measure {
      // measured [Time, seconds] average: 0.010
      // relative standard deviation: 3.752%
      // values: [0.009711, 0.009546, 0.009515, 0.010169, 0.010729, 0.010279, 0.010158, 0.009926, 0.010097, 0.009548]
      let pairCount = findPairsUsingDictionary(numbers: testCase.numbers, k: testCase.k)

      XCTAssert(
        pairCount == testCase.solution,
        "Expected \(testCase.solution) pairs, but got \(pairCount) for large test case."
      )
    }
  }
}

KDiffTests.defaultTestSuite.run()

