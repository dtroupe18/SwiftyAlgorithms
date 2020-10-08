import UIKit

// REF: https://leetcode.com/problems/median-of-two-sorted-arrays/
//
// Solution
// 1. Merge the two arrays.
// 2. Return the middle element.

import XCTest
import Foundation

struct TestCase {
  let array1: [Int]
  let array2: [Int]
  let solution: Double
}

final class MedianOfTwoSortedArrays: XCTestCase {
  private let testCases: [TestCase] = [
    TestCase(
      array1: [1, 3],
      array2: [2],
      solution: 2.0
    ),
    TestCase(
      array1: [1, 2],
      array2: [3, 4],
      solution: 2.5
    ),
    TestCase(
      array1: [0, 0],
      array2: [0, 0],
      solution: 0.0
    ),
    TestCase(
      array1: [],
      array2: [2],
      solution: 2.0
    ),
    TestCase(
      array1: [-5, 3, 6, 12, 15],
      array2: [-12, -10, -6, -3, 4, 10],
      solution: 3.0
    ),
    TestCase(
      array1: [2, 3, 5, 8],
      array2: [10, 12, 14, 16, 18, 20],
      solution: 11.0
    )
  ]

  func medianOfArray(_ nums: [Int]) -> Double {
    guard !nums.isEmpty else { return 0.0 }
    guard nums.count > 1 else { return Double(nums[0]) }

    if nums.count % 2 == 1 {
      return Double(nums[nums.count / 2])
    } else {
      let mid = nums.count / 2
      return Double(nums[mid - 1] + nums[mid]) / 2.0
    }
  }

  /**
   Runtime: 88 ms, faster than 85.43% of Swift online submissions for Median of Two Sorted Arrays.
   Memory Usage: 14.6 MB, less than 97.48% of Swift online submissions for Median of Two Sorted Arrays.
   */
  func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    if nums1.isEmpty {
      return medianOfArray(nums2)
    }

    if nums2.isEmpty {
      return medianOfArray(nums1)
    }

    var merged: [Int] = []

    var index1: Int = 0
    var index2: Int = 0

    var value1 = nums1[0]
    var value2 = nums2[0]

    while merged.count < nums1.count + nums2.count {
      if value1 <= value2 {
        merged.append(value1)
        index1 += 1

        if index1 < nums1.count {
          value1 = nums1[index1]
        } else {
          merged.append(contentsOf: nums2[index2...])
        }
      } else {
        merged.append(value2)
        index2 += 1

        if index2 < nums2.count {
          value2 = nums2[index2]
        } else {
          merged.append(contentsOf: nums1[index1...])
        }
      }
    }

    return medianOfArray(merged)
  }

  func testMedianOfTwoArrays() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let median = findMedianSortedArrays(testCase.array1, testCase.array2)
      XCTAssert(median == solution, "Expected: \(solution) but got: \(median) for testCase \(i)")
    }
  }
}

MedianOfTwoSortedArrays.defaultTestSuite.run()
