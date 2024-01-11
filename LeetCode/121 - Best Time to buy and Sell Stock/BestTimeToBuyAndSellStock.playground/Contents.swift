/**
 Problem:

 Say you have an array for which the ith element is the price of a given stock on day i.

 If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.

 Note that you cannot sell a stock before you buy one.

 Example 1:

 Input: [7,1,5,3,6,4]
 Output: 5

 Explanation:
  Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
  Not 7-1 = 6, as selling price needs to be larger than buying price.


 Example 2:

 Input: [7,6,4,3,1]
 Output: 0

 Explanation:
  In this case, no transaction is done, i.e. max profit = 0.

 [Ref](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)
 */
import Foundation
import XCTest

struct TestCase {
  let prices: [Int]
  let maxProfit: Int
}

class BestTimeToBuyAndSellStock: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(prices: [7,1,5,3,6,4], maxProfit: 5),
    TestCase(prices: [7, 50, 1, 8, 20], maxProfit: 43)
  ]

  /**
   Complexity O(n)

   Runtime: 32 ms, faster than 97.86% of Swift online submissions for Best Time to Buy and Sell Stock.
   Memory Usage: 21.3 MB, less than 16.67% of Swift online submissions for Best Time to Buy and Sell Stock.
   */
  func maxProfit(_ prices: [Int]) -> Int {
    // maximize b - a from the given prices
    guard prices.count > 1 else { return 0 }

    var minBuyingPrice: Int = Int.max
    var maxProfit: Int = 0

    for i in 1..<prices.count {
      // We can only sell after be buy, so if we can buy at a lower price
      // then we have previously seen, this lower price will generate more
      // profit moving forward.
      if prices[i - 1] < minBuyingPrice{
        minBuyingPrice = prices[i - 1]
      }

      // Given our min buying price can we generate more profit then we previously did.
      maxProfit = max(prices[i] - minBuyingPrice, maxProfit)
    }

    return maxProfit
  }

  func test() {
    for (i, testCase) in testCases.enumerated() {
      let result = maxProfit(testCase.prices)

      XCTAssertEqual(result, testCase.maxProfit, "Expected \(testCase.maxProfit), but got \(result) for test case \(i)")
    }
  }
}

BestTimeToBuyAndSellStock.defaultTestSuite.run()
