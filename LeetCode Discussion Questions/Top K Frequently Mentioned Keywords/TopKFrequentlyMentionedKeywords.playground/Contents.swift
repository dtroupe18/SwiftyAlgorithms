/**
 Problem:

 Given a list of reviews, a list of keywords and an integer k.
 Find the most popular k keywords in order of most to least frequently mentioned.
 The comparison of strings is case-insensitive.
 If keywords are mentioned an equal number of times in reviews, sort alphabetically.

 Example 1:

 Input:
 k = 2
 keywords = ["anacell", "cetracular", "betacellular"]
 reviews = [
   "Anacell provides the best services in the city",
   "betacellular has awesome services",
   "Best services provided by anacell, everyone should use anacell",
 ]

 Output:
 ["anacell", "betacellular"]

 Explanation:
 "anacell" is occuring in 2 different reviews and "betacellular" is only occuring in 1 review.


 Example 2:

 Input:
 k = 2
 keywords = ["anacell", "betacellular", "cetracular", "deltacellular", "eurocell"]
 reviews = [
 "I love anacell Best services; Best services provided by anacell",
 "betacellular has great services",
 "deltacellular provides much better services than betacellular",
 "cetracular is worse than anacell",
 "Betacellular is better than deltacellular.",
 ]

 Output:
 ["betacellular", "anacell"]

 Explanation:
 "betacellular" is occuring in 3 different reviews. "anacell" and "deltacellular" are occuring in 2 reviews,
 but "anacell" is lexicographically smaller.


[Ref](https://leetcode.com/discuss/interview-question/542597/)
 */

import Foundation
import XCTest

struct TestCase {
  let k: Int
  let keywords: [String]
  let reviews: [String]

  let solution: [String]
}

final class TopKFrequentlyMentionedKeywordTests: XCTestCase {
  private let testCases: [TestCase] = [
    TestCase(
      k: 2,
      keywords: ["anacell", "cetracular", "betacellular"],
      reviews: [
        "Anacell provides the best services in the city",
        "betacellular has awesome services",
        "Best services provided by anacell, everyone should use anacell",
      ],
      solution: ["anacell", "betacellular"]
    ),
    TestCase(
      k: 1,
      keywords: ["cetracular"],
      reviews: [
        "Anacell provides the best services in the city",
        "betacellular has awesome services",
        "Best services provided by anacell, everyone should use anacell",
      ],
      solution: []
    ),
    TestCase(
      k: 0,
      keywords: [],
      reviews: [
        "Anacell provides the best services in the city",
        "betacellular has awesome services",
        "Best services provided by anacell, everyone should use anacell",
      ],
      solution: []
    ),
    TestCase(
      k: 2,
      keywords: ["Anacell", "cetracular", "Betacellular"],
      reviews: [
        "Anacell provides the best services in the city",
        "betacellular has awesome services",
        "Best services provided by anacell, everyone should use anacell",
      ],
      solution: ["anacell", "betacellular"]
    ),
    TestCase(
      k: 2,
      keywords: ["anacell", "betacellular", "cetracular", "deltacellular", "eurocell"],
      reviews: [
        "I love anacell Best services; Best services provided by anacell",
        "betacellular has great services",
        "deltacellular provides much better services than betacellular",
        "cetracular is worse than anacell",
        "Betacellular is better than deltacellular.",
      ],
      solution: ["betacellular", "anacell"]
    )
  ]

  private func topKFrequent(_ reviews: [String], _ keywords: [String], _ k: Int) -> [String] {
    assert(k <= keywords.count)
    guard k > 0, keywords.count > 0 else { return [] }

    var wordCounts: [String: Int] = [:]

    // Not sure if keywords are guarenteed to be lowercase in the input.
    let lowerCaseKeywords = keywords.map { $0.lowercased() }

    for review in reviews {
      let words = review.lowercased().components(separatedBy: " ")

      // We are counting the number of reviews the word occurs in not the number of times
      // it occurs over all i.e. `"I love anacell Best services; Best services provided by anacell"`
      // should add 1 not 2 to the count for anacell.
      var alreadyCounted: [String: Int] = [:]

      for word in words where lowerCaseKeywords.contains(word) {
        if alreadyCounted[word] == nil {
          alreadyCounted[word, default: 0] += 1
          wordCounts[word, default: 0] += 1
        }
      }
    }

    // No Heap in `Swift` :[
    let sorted = wordCounts.sorted(by: { d1, d2 -> Bool in
      if d1.value != d2.value {
        return d1.value > d2.value
      } else {
        return d1.key < d2.key
      }
    }).map { $0.key }

    guard sorted.count >= k else {
      // Return whatever we have.
      return sorted
    }

    return Array(sorted[0..<k])
  }

  func testTopKFrequent() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let mostFreqWords = topKFrequent(testCase.reviews, testCase.keywords, testCase.k)

      XCTAssert(mostFreqWords == solution, "Expected: \(solution) but got: \(mostFreqWords) for testCase \(i)")
    }
  }

  func testTopKPerformance() {
    let testCase = testCases[0]
    measure {
      _ = topKFrequent(testCase.reviews, testCase.keywords, testCase.k)
    }
  }
}

TopKFrequentlyMentionedKeywordTests.defaultTestSuite.run()
