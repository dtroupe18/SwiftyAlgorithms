/**
 Problem

 Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

 Example:

 Input:
 [
 1->4->5,
 1->3->4,
 2->6
 ]

 Output: 1->1->2->3->4->4->5->6

 [Ref](https://leetcode.com/problems/merge-k-sorted-lists/)
 */

import Foundation
import XCTest

// Provided by the question.
public class ListNode: CustomStringConvertible {
  public var val: Int
  public var next: ListNode?
  public init(_ val: Int) {
    self.val = val
    self.next = nil
  }

  public var description: String {
    var desc: String = ""

    var last: ListNode? = self
    desc += "\(String(describing: last?.val))"

    while last?.next != nil {
      let next = last?.next
      desc += "\(String(describing: next?.val))"
      last = next
    }

    return desc
  }
}

final class MergeKSortedLists: XCTestCase {
  func makeLists() -> [ListNode] {
    let l11 = ListNode(1)
    let l12 = ListNode(4)
    l11.next = l12

    let l13 = ListNode(5)
    l12.next = l13

    let l21 = ListNode(1)
    let l22 = ListNode(3)
    l21.next = l22

    let l23 = ListNode(4)
    l22.next = l23

    let l31 = ListNode(2)
    let l32 = ListNode(6)
    l31.next = l32

    return [l11, l21, l31]
  }

  /**
   Runtime: 72 ms, faster than 93.73% of Swift online submissions for Merge k Sorted Lists.
   Memory Usage: 23.1 MB, less than 37.50% of Swift online submissions for Merge k Sorted Lists.

   Complexity: The nested loop to build the initial array is O(n * k) where k is the length of the sub-list.
   Then we have O(nlogn) for the sort and another O(n) for the final list construction. We can drop the factor
   out front of k and go with O(nlogn).
   */
  func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    if lists.isEmpty { return nil }

    var array: [Int] = []

    for i in 0..<lists.count {
      var node = lists[i]

      while node != nil {
        array.append(node!.val)
        node = node!.next
      }
    }

    if array.isEmpty { return nil }
    array = array.sorted()

    let head = ListNode(array[0])
    var node = head

    for i in 1..<array.count {
      node.next = ListNode(array[i])
      node = node.next!
    }

    return head
  }

  func testMergeKSortedLists() {
    let result = mergeKLists(makeLists())
    let solution = [1, 1, 2, 3, 4, 4, 5, 6]

    var lastResult = result
    var solutionIndex: Int = 0

    while lastResult != nil {
      XCTAssertTrue(lastResult?.val == solution[solutionIndex], "Expected \(solution[solutionIndex]) got \(String(describing: lastResult?.val))")
      lastResult = lastResult?.next
      solutionIndex += 1
    }
  }
}

MergeKSortedLists.defaultTestSuite.run()
