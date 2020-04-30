/**
 Problem
 
 Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right which minimizes the sum of all numbers along its path.
 
 Note: You can only move either down or right at any point in time.
 
 Example:
 
 Input:
 [
 [1,3,1],
 [1,5,1],
 [4,2,1]
 ]
 Output: 7
 Explanation: Because the path 1→3→1→1→1 minimizes the sum.
 
 [Ref](https://leetcode.com/problems/minimum-path-sum/)
 */

import Foundation
import XCTest

class Solution {
  // Runtime: 60 ms, faster than 96.56% of Swift online submissions for Minimum Path Sum.
  // Memory Usage: 21.2 MB, less than 50.00% of Swift online submissions for Minimum Path Sum.
  func minPathSum(_ grid: [[Int]]) -> Int {
    if grid.isEmpty { return 0 }
    if grid.count == 1 {
      var sum = 0
      
      for val in grid[0] {
        sum += val
      }
      
      return sum
    }
    
    var grid = grid // mutable
    
    for i in 0..<grid.count {
      for j in 0..<grid[i].count {
        if i == 0 && j == 0 { continue }
        
        let currentCost = grid[i][j]
        var leftCost = Int.max
        var aboveCost = Int.max
        
        // can we get there from the left?
        if j > 0 {
          leftCost = currentCost + grid[i][j - 1]
        }
        
        if i > 0 {
          aboveCost = currentCost + grid[i - 1][j]
        }
        
        let minCost = min(leftCost, aboveCost)
        grid[i][j] = minCost
      }
    }
    
    let rowCount = grid.count
    let lastCol = grid[rowCount - 1].count
    
    return grid[rowCount - 1][lastCol - 1]
  }
}
