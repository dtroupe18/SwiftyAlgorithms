/**
 Problem

 Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

 Example:

 Input:
 [
 [1, 4, 5],
 [1, 3, 4],
 [2, 6]
 ]

 Output: [1, 1, 2, 3, 4, 4, 5, 6]

 Modified from
 [Ref](https://leetcode.com/problems/merge-k-sorted-lists/)

 [Resource](https://en.wikipedia.org/wiki/K-way_merge_algorithm#Iterative_2-Way_merge)
 */

import Foundation
import XCTest

struct TestCase {
  let lists: [[Int]]
  let solution: [Int]
}

final class MergeKSortedArrays: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(
      lists: [[1, 2, 4, 5], [2, 3, 3, 5, 6], [1, 2], [8, 9, 10]],
      solution: [1, 1, 2, 2, 2, 3, 3, 4, 5, 5, 6, 8, 9, 10]
    ),
    TestCase(lists: [[1, 2, 3], [1, 2, 3]], solution: [1, 1, 2, 2, 3, 3]),
    TestCase(lists: [], solution: []),
    TestCase(lists: [[1]], solution: [1])
  ]
  /**
   The problem can be solved by iteratively merging two of the k arrays using a 2-way merge until only a single array is left.
   If the arrays are merged in arbitrary order, then the resulting running time is only O(kn). This is suboptimal.

   The running time can be improved by iteratively merging the first with the second, the third with the fourth, and so on.
   As the number of arrays is halved in each iteration, there are only Θ(log k) iterations. In each iteration every element
   is moved exactly once. The running time per iteration is therefore in Θ(n) as n is the number of elements. The total
   running time is therefore in Θ(n log k).

   We can further improve upon this algorithm, by iteratively merging the two shortest arrays. It is clear that this minimizes
   the running time and can therefore not be worse than the strategy described in the previous paragraph. The running time is
   therefore in O(n log k). Fortunately, in border cases the running time can be better. Consider for example the degenerate case,
   where all but one array contain only one element. The strategy explained in the previous paragraph needs Θ(n log k) running time,
   while the improved one only needs Θ(n) running time.
   */
  func mergeKSortedArrays(_ lists: [[Int]]) -> [Int] {
    if lists.isEmpty { return [] }
    if lists.count == 1 { return lists[0] }

    var mergedLists = lists
    var firstIndex = 0
    var secondIndex = 1

    while mergedLists.count > 1 {
      for i in 0..<lists.count {
        // Merge each list with the next one so the number of lists
        // is cut in half each iteration.
        firstIndex += i
        secondIndex += i

        guard firstIndex < mergedLists.count,
          secondIndex < mergedLists.count else {
          break
        }

        let merged = mergeSortedArrays(array1: mergedLists[firstIndex], array2: mergedLists[secondIndex])
        mergedLists.remove(at: firstIndex)
        mergedLists.remove(at: firstIndex)

        mergedLists.append(merged)
      }

      // Start back at the beginning.
      firstIndex = 0
      secondIndex = 1
    }

    return mergedLists[0]
  }

  func mergeSortedArrays(array1: [Int], array2: [Int]) -> [Int] {
    // Get mutable copies.
    var array1 = array1
    var array2 = array2

    var merged: [Int] = []

    while !array1.isEmpty {

      guard !array2.isEmpty else {
        return merged + array1
      }

      var next: Int

      if array1.first! < array2.first! {
        next = array1.first!
        array1.removeFirst()
      } else {
        next = array2.first!
        array2.removeFirst()
      }

      merged.append(next)
    }

    // Array1 isEmpty
    return merged + array2
  }

  func testMergeKArrays() {
    for (i, testCase) in testCases.enumerated() {
      let result = mergeKSortedArrays(testCase.lists)
      let solution = testCase.solution

      XCTAssertEqual(result, solution, "Expected: \(solution), but got: \(result) for test case: \(i)")
    }
  }
}

MergeKSortedArrays.defaultTestSuite.run()
