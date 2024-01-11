import Foundation
import XCTest

struct TestCase {
  let numbers: [Int]
  let searchValue: Int
}

final class SearchTests: XCTestCase {
  private func makeRandomIntArray(length: Int, minValue: Int, maxValue: Int) -> [Int] {
    return (0..<length).map{ _ in Int.random(in: minValue ... maxValue) }
  }

  private func makeTestCases(
    numberOfCases: Int,
    minValue: Int,
    maxValue: Int,
    size: Int
  ) -> [TestCase] {
    var testCases: [TestCase] = []

    for _ in 0..<numberOfCases {
      let array = makeRandomIntArray(length: size, minValue: minValue, maxValue: maxValue)
      let searchValue = array.randomElement()!

      testCases.append(TestCase(numbers: array, searchValue: searchValue))
    }

    return testCases
  }

  private func makeLargeTestCase() -> TestCase {
    return self.makeTestCases(
      numberOfCases: 1,
      minValue: 0,
      maxValue: Int.max - 1,
      size: 1_000_000
    )[0]
  }

  /**
   Recursive Binary Search

   Require `T` to be `Comparable` so we have all our comparison operations
   <, <=, ==, >=, & >.

   - parameter array: [T] to search.
   - parameter searchValue: T value you are looking for.
   - parameter range: Range<Int> range of array to search.
   - returns: Optional `Int` index of the searchValue if it exists in array.
   - note: Binary Search requires that array is sorted.
   - note: Complexity O(log n).

   Algorithm Process:
   1. Split the array in half and determine whether the search value, is in the left half or in       the right half.
   2. If the search value is in the left half, you repeat the process there: split the left half      into two even smaller pieces and look in which piece the search key must lie. (Likewise for     when it's the right half.)
   3. This repeats until the search value is found. If the array cannot be split up any further,      you must conclude that the search value is not present in the array.
   */

  func recursiveBinarySearch<T: Comparable>(
    _ array: [T],
    searchValue: T,
    range: Range<Int>
  ) -> Int? {
    // Nothing left to search.
    guard range.lowerBound < range.upperBound else { return nil }

    // Calculate where to split the array.
    let middleIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2

    // Check if the search value is in the lower half.
    if array[middleIndex] > searchValue {
      return recursiveBinarySearch(
        array,
        searchValue: searchValue,
        range: range.lowerBound ..< middleIndex
      )

      // Check if the search value is in the upper half.
    } else if array[middleIndex] < searchValue {
      return recursiveBinarySearch(
        array,
        searchValue: searchValue,
        range: middleIndex + 1 ..< range.upperBound
      )

      // If we get here, then array[middleIndex] == searchValue.
    } else {
      return middleIndex
    }
  }

  /**
   Iterative Binary Search

   Binary search is recursive by definition, because we perform the same logic repeatedly
   on smaller subarrays. However, this doesn't mean that Binary Search must be implemented using
   recursion. Here we implement Binary Search iteratively to compare performance.

   Require `T` to be `Comparable` so we have all our comparison operations
   <, <=, ==, >=, & >.

   - parameter array: [T] to search.
   - parameter searchValue: T value you are looking for.
   - returns: Optional `Int` index of the searchValue if it exists in array.
   */

  func iterativeBinarySearch<T: Comparable>(_ array: [T], searchValue: T) -> Int? {
    var lowerBound = 0
    var upperBound = array.count

    while lowerBound < upperBound {
      let middleIndex = lowerBound + (upperBound - lowerBound) / 2

      if array[middleIndex] == searchValue {
        return middleIndex
      } else if array[middleIndex] < searchValue {
        lowerBound = middleIndex + 1
      } else {
        upperBound = middleIndex
      }
    }

    // LowerBound is no longer < UpperBound.
    return nil
  }

  /**
   Linear Search

   Here we only require that `T` is `Equatable` because we only use `==`.

   Algorithm Process:
   Linear search, we iterate over all the objects in the array and compare each one to the object we're looking for. If the two objects are equal, we stop and return the current array index. If not, we continue to look for the next object as long as we have objects in the array.

   - note: Complexity O(n).
   */
  func linearSearch<T: Equatable>(_ array: [T], searchValue: T) -> Int? {
    for i in 0 ..< array.count {
      if array[i] == searchValue {
        return i
      }
    }
    return nil
  }

  /**
   Apple Linear Search

   Here we use `firstIndex` which implements a linear search to compare performance.
   */
  func appleLinearSearch<T: Equatable>(_ array: [T], searchValue: T) -> Int? {
    return array.firstIndex(of: searchValue)
  }

  func testRecursiveBinarySearch() {
    let testCases = self.makeTestCases(
      numberOfCases: 10,
      minValue: 0,
      maxValue: 10_000,
      size: 1000
    )

    for testCase in testCases {
      let sorted = Set(testCase.numbers).sorted()

      guard let index = recursiveBinarySearch(
        sorted,
        searchValue: testCase.searchValue,
        range: 0 ..< sorted.count
        ) else {
          XCTFail("Failed to find index for \(testCase.searchValue) in \(sorted)")
          return
      }

      XCTAssert(
        sorted[index] == testCase.searchValue,
        "Expected \(testCase.searchValue) but got \(sorted[index])"
      )
    }
  }

  func testIterativeBinarySearch() {
    let testCases = self.makeTestCases(
      numberOfCases: 10,
      minValue: 0,
      maxValue: 10_000,
      size: 1000
    )

    for testCase in testCases {
      let sorted = Set(testCase.numbers).sorted()

      guard let index = iterativeBinarySearch(sorted, searchValue: testCase.searchValue) else {
        XCTFail("Failed to find index for \(testCase.searchValue) in \(sorted)")
        return
      }

      XCTAssert(
        sorted[index] == testCase.searchValue,
        "Expected \(testCase.searchValue) but got \(sorted[index])"
      )
    }
  }

  func testLinearSearch() {
    let testCases = self.makeTestCases(
      numberOfCases: 10,
      minValue: 0,
      maxValue: 10_000,
      size: 1000
    )

    for testCase in testCases {
      // No need to sort here.
      guard let index = linearSearch(testCase.numbers, searchValue: testCase.searchValue) else {
        XCTFail("Failed to find index for \(testCase.searchValue) in \(testCase.numbers)")
        return
      }

      XCTAssert(
        testCase.numbers[index] == testCase.searchValue,
        "Expected \(testCase.searchValue) but got \(testCase.numbers)"
      )
    }
  }

  func testAppleLinearSearch() {
    let testCases = self.makeTestCases(
      numberOfCases: 10,
      minValue: 0,
      maxValue: 10_000,
      size: 1000
    )

    for testCase in testCases {
      // No need to sort here.
      guard let index = appleLinearSearch(testCase.numbers, searchValue: testCase.searchValue) else {
        XCTFail("Failed to find index for \(testCase.searchValue) in \(testCase.numbers)")
        return
      }

      XCTAssert(
        testCase.numbers[index] == testCase.searchValue,
        "Expected \(testCase.searchValue) but got \(testCase.numbers)"
      )
    }
  }


  // MARK: Performance

  func testPerformanceForRecursiveBinarySearch() {
    let testCase = self.makeLargeTestCase()

    // We have to sort this array before we can use binary search.
    let sorted = Set(testCase.numbers).sorted()

    measure {
      guard let index = recursiveBinarySearch(sorted, searchValue: testCase.searchValue, range: 0..<sorted.count) else {
        XCTFail("Failed to find searchValue: \(testCase.searchValue)")
        return
      }

      XCTAssert(
        sorted[index] == testCase.searchValue,
        "Expected \(testCase.searchValue) but got \(sorted[index])."
      )
    }
  }

  func testPerformanceForIterativeBinarySearch() {
    let testCase = self.makeLargeTestCase()

    // We have to sort this array before we can use binary search.
    let sorted = Set(testCase.numbers).sorted()

    measure {
      guard let index = iterativeBinarySearch(sorted, searchValue: testCase.searchValue) else {
        XCTFail("Failed to find searchValue: \(testCase.searchValue)")
        return
      }

      XCTAssert(
        sorted[index] == testCase.searchValue,
        "Expected \(testCase.searchValue) but got \(sorted[index])."
      )
    }
  }

  func testPerformanceOfLinearSearch() {
    // measured [Time, seconds] average: 0.732
    // relative standard deviation: 2.598%
    // values: [0.681997, 0.746131, 0.741263, 0.743860, 0.741833, 0.745078, 0.736219, 0.742634, 0.725057, 0.716387]
    let testCase = self.makeLargeTestCase()
    let unique = Array(Set(testCase.numbers))

    measure {
      // No need to sort.
      guard let index = linearSearch(unique, searchValue: testCase.searchValue) else {
        XCTFail("Failed to find searchValue: \(testCase.searchValue)")
        return
      }

      XCTAssert(
        unique[index] == testCase.searchValue,
        "Expected \(testCase.searchValue) but got \(unique[index])."
      )
    }
  }

  func testPerformanceOfAppleLinearSearch() {
    // measured [Time, seconds] average: 0.121
    // relative standard deviation: 1.294%
    // values: [0.119174, 0.123748, 0.119452, 0.120141, 0.123905, 0.120586, 0.120155, 0.121936, 0.121568, 0.120595]
    let testCase = self.makeLargeTestCase()
    let unique = Array(Set(testCase.numbers))

    measure {
      // No need to sort.
      guard let index = appleLinearSearch(unique, searchValue: testCase.searchValue) else {
        XCTFail("Failed to find searchValue: \(testCase.searchValue)")
        return
      }

      XCTAssert(
        unique[index] == testCase.searchValue,
        "Expected \(testCase.searchValue) but got \(unique[index])."
      )
    }
  }
}

SearchTests.defaultTestSuite.run()
