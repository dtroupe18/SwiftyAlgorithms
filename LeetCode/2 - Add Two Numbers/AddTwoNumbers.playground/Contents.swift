/**
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.

 Example:

 Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 0 -> 8
 Explanation: 342 + 465 = 807.
 */

import Foundation
import XCTest

class AddTwoNumbers: XCTestCase {
  public class ListNode {
    public var val: Int
    public var next: ListNode?

    public init(_ val: Int) {
      self.val = val
      self.next = nil
    }
  }

  // Runtime: 56 ms, faster than 17.41% of Swift online submissions for Add Two Numbers.
  // Memory Usage: 21.1 MB, less than 11.11% of Swift online submissions for Add Two Numbers.
  func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var l1 = l1
    var l2 = l2

    let fakeHead = ListNode(-1) // just return .next
    var lastNode = fakeHead
    var remainder = 0
    var sum = 0

    while l1 != nil || l2 != nil {
      sum = 0

      if let val1 = l1?.val {
        sum += val1
      }

      if let val2 = l2?.val {
        sum += val2
      }

      sum += remainder

      if sum > 9 {
        sum = sum % 10
        remainder = 1
      } else {
        remainder = 0
      }

      let nextNode = ListNode(sum)
      lastNode.next = nextNode
      lastNode = nextNode

      l1 = l1?.next
      l2 = l2?.next
    }

    if remainder == 1 {
      let nextNode = ListNode(1)
      lastNode.next = nextNode
      lastNode = nextNode
    }

    return fakeHead.next
  }

  func testAddition() {
    var result = addTwoNumbers(ListNode(5), ListNode(5))
    let solution = [0, 1]

    var i = 0
    while result != nil {
      XCTAssertEqual(result?.val, solution[i])
      result = result?.next
      i += 1
    }
  }
}

AddTwoNumbers.defaultTestSuite.run()
