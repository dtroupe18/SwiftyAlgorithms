/**
 Problem

 Given two non-empty binary trees s and t, check whether tree t has exactly the same structure and node values with a subtree of s. A subtree of s is a tree consists of a node in s and all of this node's descendants. The tree s could also be considered as a subtree of itself.

 Example 1:

 Given tree s:

 3
 / \
 4   5
 / \
 1   2

 Given tree t:
 4
 / \
 1   2

 Return true, because t has the same structure and node values with a subtree of s.


 Example 2:

 Given tree s:

 3
 / \
 4   5
 / \
 1   2
 /
 0

 Given tree t:
 4
 / \
 1   2

 Return false.

 [Ref](https://leetcode.com/problems/subtree-of-another-tree/)
 */

import Foundation
import XCTest

public class TreeNode {
  public var val: Int
  public var left: TreeNode?
  public var right: TreeNode?
  public init(_ val: Int) {
    self.val = val
    self.left = nil
    self.right = nil
  }
}

class Solution {
  // Runtime: 440 ms, faster than 5.39% of Swift online submissions for Subtree of Another Tree.
  // Memory Usage: 21.3 MB, less than 100.00% of Swift online submissions for Subtree of Another Tree.
  func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
    // Find the root node of the subtree in t
    // if this doesn't exist return false.

    if s == nil {
      return t == nil
    } else if t == nil {
      return s == nil
    }

    let s = s!
    let t = t!

    let subRoot = t.val

    // BFS kinda
    var q: [TreeNode] = [s]

    // print(s.val)

    while !q.isEmpty {
      let node = q.removeLast()
      let left = node.left
      let right = node.right

      // What if there are multiple values? (edge case)

      // We found the start of the subtree
      if node.val == subRoot {
        if treesMatch(node, t) {
          return true
        }
      }

      // Keep searching
      if let l = left {
        // print("adding left \(l.val)")
        q.append(l)
      }

      if let r = right {
        // print("adding right \(r.val)")
        q.append(r)
      }
    }

    return false
  }

  func treesMatch(_ n1: TreeNode, _ n2: TreeNode) -> Bool {
    // Make sure the trees are an exact match.
    // BFS and make sure everything matches?
    var givenSubTreeQ: [TreeNode?] = [n1]
    var foundSubTreeQ: [TreeNode?] = [n2]

    // print("found root")

    while !foundSubTreeQ.isEmpty {
      let givenNode = givenSubTreeQ.removeLast()
      let foundNode = foundSubTreeQ.removeLast()

      if areEqual(givenNode, foundNode) {
        if givenNode != nil {
          givenSubTreeQ.append(givenNode!.right)
          givenSubTreeQ.append(givenNode!.left)
        }

        if foundNode != nil {
          foundSubTreeQ.append(foundNode!.right)
          foundSubTreeQ.append(foundNode!.left)
        }
      } else {
        // print("not equal so false")
        return false
      }
    }

    return true // We walked the whole tree and everything matched
  }

  // Helper func
  func areEqual(_ n1: TreeNode?, _ n2: TreeNode?) -> Bool {
    if n1 == nil {
      return n2 == nil
    }

    if n2 == nil {
      return n1 == nil
    }

    let n1 = n1!
    let n2 = n2!

    return n1.val == n2.val
  }
}
