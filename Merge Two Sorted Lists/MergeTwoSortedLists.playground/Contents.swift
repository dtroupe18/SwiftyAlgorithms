/**
 Problem

 Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

 Example:

 Input: 1->2->4, 1->3->4
 Output: 1->1->2->3->4->4
 */

import Foundation
import XCTest

public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init(_ val: Int) {
    self.val = val
    self.next = nil
  }
}

final class MergeTwoSortedLists: XCTestCase {
  func makeL1() -> ListNode {
    // 1->2->4
    let first = ListNode(1)
    let second = ListNode(2)
    let third = ListNode(4)

    first.next = second
    second.next = third

    return first
  }

  func makeL2() -> ListNode {
    // 1->3->4
    let first = ListNode(1)
    let second = ListNode(3)
    let third = ListNode(4)

    first.next = second
    second.next = third

    return first
  }

  func makeSolution() -> ListNode {
    let first = ListNode(1)
    let second = ListNode(1)
    let third = ListNode(2)
    let fourth = ListNode(3)
    let fifth = ListNode(4)
    let sixth = ListNode(4)

    first.next = second
    second.next = third
    third.next = fourth
    fourth.next = fifth
    fifth.next = sixth

    return first
  }

  // Recursive
  //
  // Runtime: 16 ms, faster than 69.79% of Swift online submissions for Merge Two Sorted Lists.
  // Memory Usage: 21.1 MB, less than 25.00% of Swift online submissions for Merge Two Sorted Lists.
  func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    guard let l1 = l1 else { return l2 }
    guard let l2 = l2 else { return l1 }

    if l1.val < l2.val {
      l1.next = mergeTwoLists(l1.next, l2)
      return l1
    } else {
      l2.next = mergeTwoLists(l2.next, l1)
      return l2
    }
  }

  // Iterative.
  //
  // Runtime: 16 ms, faster than 69.79% of Swift online submissions for Merge Two Sorted Lists.
  // Memory Usage: 20.9 MB, less than 25.00% of Swift online submissions for Merge Two Sorted Lists.
  func mergeTwoListsIterative(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var l3: ListNode? = ListNode(-1)
    let fakeFirstNode = l3

    var l1 = l1
    var l2 = l2

    while l1 != nil, l2 != nil {
      if l1!.val < l2!.val {
        l3?.next = l1
        l1 = l1?.next
      } else {
        l3?.next = l2
        l2 = l2?.next
      }

      l3 = l3?.next
    }

    if l1 == nil {
      l3?.next = l2
    }

    if l2 == nil {
      l3?.next = l1
    }

    return fakeFirstNode?.next
  }

  func testMergeTwoLists() {
    let result = mergeTwoLists(makeL1(), makeL2())
    let solution = makeSolution()

    var lastResult = result
    var lastSolution: ListNode? = solution

    while lastSolution != nil {
      XCTAssertTrue(lastSolution?.val == lastResult?.val)
      lastResult = lastResult?.next
      lastSolution = lastSolution?.next
    }
  }

  func testMergeTwoListsIterative() {
    let result = mergeTwoListsIterative(makeL1(), makeL2())
    let solution = makeSolution()

    var lastResult = result
    var lastSolution: ListNode? = solution

    while lastSolution != nil {
      XCTAssertTrue(lastSolution?.val == lastResult?.val)
      lastResult = lastResult?.next
      lastSolution = lastSolution?.next
    }
  }
}
