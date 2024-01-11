/**
 Trapping Rain Water

 Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.

 Examples:

 Input: arr[] = {2, 0, 2}
 Output: 2
 Structure is like below
 | |
 |_|
 We can trap 2 units of water in the middle gap.

 Input: arr[]   = {3, 0, 0, 2, 0, 4}
 Output: 10
 Structure is like below
      |
 |    |
 |  | |
 |__|_|
 We can trap "3*2 units" of water between 3 an 2,
 "1 unit" on top of bar 2 and "3 units" between 2
 and 4.  See below diagram also.

 Input: arr[] = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
 Output: 6
        |
    |   || |
 _|_||_||||||
 Trap "1 unit" between first 1 and 2, "4 units" between
 first 2 and 3 and "1 unit" between second last 1 and last 2

 [Ref](https://leetcode.com/problems/trapping-rain-water/)
 */

import Foundation
import XCTest

class TrappingRainWater: XCTestCase {

  // Runtime: 32 ms, faster than 39.25% of Swift online submissions for Trapping Rain Water.
  // Memory Usage: 21.2 MB, less than 25.00% of Swift online submissions for Trapping Rain Water.
  func trap(_ height: [Int]) -> Int {
    guard height.count >= 3 else { return 0 }

    var leftHeights: [Int] = []
    leftHeights.append(height[0])

    var rightHeights: [Int] = []
    for _ in 0..<height.count {
      rightHeights.append(-1)
    }

    var water: Int = 0

    for i in 1..<height.count {
      leftHeights.append(max(leftHeights[i - 1], height[i]))
    }

    rightHeights[height.count - 1] = height[height.count - 1]

    for i in (0...height.count - 2).reversed() {

      rightHeights[i] = max(rightHeights[i + 1], height[i])
    }

    // Calculate the accumulated water element by element
    // consider the amount of water on i'th bar, the
    // amount of water accumulated on this particular
    // bar will be equal to min(left[i], right[i]) - arr[i].

    // print("left: \(leftHeights)")
    // print("right: \(rightHeights)")

    for i in 0..<height.count {
      let w = min(leftHeights[i], rightHeights[i]) - height[i]
      // print("Water at \(i) = \(w)")
      water += w
    }

    return water
  }

  func testTrap() {
    let capacity = trap([0,1,0,2,1,0,1,3,2,1,2,1])

    XCTAssertEqual(capacity, 6)
  }
}

TrappingRainWater.defaultTestSuite.run()
