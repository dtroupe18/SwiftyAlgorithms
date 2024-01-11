/**
 Problem

 Given a singly linked list, group all odd nodes together followed by the even nodes.
 Please note here we are talking about the node number and not the value in the nodes.

 You should try to do it in place. The program should run in O(1) space complexity and O(nodes) time complexity.

 Example 1:

 Input: 1->2->3->4->5->NULL
 Output: 1->3->5->2->4->NULL
 Example 2:

 Input: 2->1->3->5->6->4->7->NULL
 Output: 2->3->6->7->1->5->4->NULL

 Note:
 The relative order inside both the even and odd groups should remain as it was in the input.
 The first node is considered odd, the second node even and so on ...
 */

import Foundation
import XCTest

struct TestCase {
  let weights: [Int]
  let days: Int
  let solution: Int
}

public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init(_ val: Int) {
    self.val = val
    self.next = nil
  }
}

final class OddEvenLinkedListTests: XCTestCase {
  func makeL1() -> ListNode {
    // 1->2->3->4->5->NULL
    let first = ListNode(1)
    let second = ListNode(2)
    let third = ListNode(3)
    let four = ListNode(4)
    let five = ListNode(5)

    first.next = second
    second.next = third
    third.next = four
    four.next = five

    return first
  }

  func makeSolution() -> ListNode {
    // 1->3->5->2->4->NULL
    let first = ListNode(1)
    let second = ListNode(2)
    let third = ListNode(3)
    let four = ListNode(4)
    let five = ListNode(5)

    first.next = third
    third.next = five
    five.next = second
    second.next = four

    return first
  }

  func oddEvenList(_ head: ListNode?) -> ListNode? {
    if head == nil { return nil }

    let head = head
    var odd = head
    var even = head?.next
    let evenHead = even

    while (even != nil && even?.next != nil) {
      odd?.next = even?.next
      odd = odd?.next
      even?.next = odd?.next
      even = even?.next
    }

    odd?.next = evenHead
    return head
  }


  func testOddEvenList() {
    let result = oddEvenList(makeL1())
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

OddEvenLinkedListTests.defaultTestSuite.run()
