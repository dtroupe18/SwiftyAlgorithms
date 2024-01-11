/**
 Problem

 Given an array of strings products and a string searchWord. We want to design a system that suggests at most three product names from products after each character of searchWord is typed. Suggested products should have common prefix with the searchWord. If there are more than three products with a common prefix return the three lexicographically minimums products.

 Return list of lists of the suggested products after each character of searchWord is typed.

 Example 1:

 Input: products = ["mobile","mouse","moneypot","monitor","mousepad"], searchWord = "mouse"
 Output: [
 ["mobile","moneypot","monitor"],
 ["mobile","moneypot","monitor"],
 ["mouse","mousepad"],
 ["mouse","mousepad"],
 ["mouse","mousepad"]
 ]

 Explanation:

 Products sorted lexicographically = ["mobile","moneypot","monitor","mouse","mousepad"]
 After typing m and mo all products match and we show user ["mobile","moneypot","monitor"]
 After typing mou, mous and mouse the system suggests ["mouse","mousepad"]

 Example 2:

 Input: products = ["havana"], searchWord = "havana"
 Output: [["havana"],["havana"],["havana"],["havana"],["havana"],["havana"]]

 Example 3:

 Input: products = ["bags","baggage","banner","box","cloths"], searchWord = "bags"
 Output: [["baggage","bags","banner"],["baggage","bags","banner"],["baggage","bags"],["bags"]]

 Example 4:

 Input: products = ["havana"], searchWord = "tatiana"
 Output: [[],[],[],[],[],[],[]]

 Constraints:

 1 <= products.length <= 1000
 There are no repeated elements in products.
 1 <= Σ products[i].length <= 2 * 10^4
 All characters of products[i] are lower-case English letters.
 1 <= searchWord.length <= 1000
 All characters of searchWord are lower-case English letters.

 [Ref](https://leetcode.com/problems/search-suggestions-system/)
 */

import Foundation
import XCTest

struct TestCase {
  let products: [String]
  let searchWord: String
  let solution: [[String]]
}

final class SearchSuggestionSystem: XCTestCase {
  private let testCases: [TestCase] = [
    TestCase(
      products: ["mobile","mouse","moneypot","monitor","mousepad"],
      searchWord: "mouse",
      solution: [
        ["mobile","moneypot","monitor"],
        ["mobile","moneypot","monitor"],
        ["mouse","mousepad"],
        ["mouse","mousepad"],
        ["mouse","mousepad"]
      ]
    ),
    TestCase(
      products: ["havana"],
      searchWord: "havana",
      solution: [
        ["havana"],
        ["havana"],
        ["havana"],
        ["havana"],
        ["havana"],
        ["havana"]
      ]
    ),
    TestCase(
      products: ["bags","baggage","banner","box","cloths"],
      searchWord: "bags",
      solution: [
        ["baggage","bags","banner"],
        ["baggage","bags","banner"],
        ["baggage","bags"],
        ["bags"]
      ]
    ),
    TestCase(
      products: ["havana"],
      searchWord: "tatiana",
      solution: [[],[],[],[],[],[],[]]
    )
  ]

  func suggestedProducts(_ products: [String], _ searchWord: String) -> [[String]] {
    // Sort the products first so as we iterate over them once we have 3 we can break.
    // We can also break if we encounter a word that starts with a letter after out
    // searchWord's first letter. This adds O(nlogn) to our complexity though.
    let sortedProducts = products.sorted(by: <)
    let characters = Array(searchWord)

    var suggestions: [[String]] = []
    var currentSearchWord: String = ""
    var index: Int = 0

    for character in characters {
      var currentSuggestions: [String] = []
      currentSearchWord.append(character)

      // We reached the end.
      if index >= sortedProducts.count {
        suggestions.append(currentSuggestions)
        continue
      }

      // "mobile" < "m" == false
      while index < sortedProducts.count, sortedProducts[index] < currentSearchWord {
        index += 1
      }

      var indexCopy = index
      for _ in 0..<3 {
        if indexCopy >= sortedProducts.count {
          break
        }

        if sortedProducts[indexCopy].hasPrefix(currentSearchWord) {
          currentSuggestions.append(sortedProducts[indexCopy])
          indexCopy += 1
        } else {
          break
        }
      }

      suggestions.append(currentSuggestions)
    }

    return suggestions
  }

  func testSuggestedProducts() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let suggestions = suggestedProducts(testCase.products, testCase.searchWord)

      XCTAssert(suggestions == solution, "Expected: \(solution) but got: \(suggestions) for testCase \(i)")
    }
  }
}

SearchSuggestionSystem.defaultTestSuite.run()
