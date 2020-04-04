import Foundation
import XCTest

struct TestCase {
  let k: Int
  let keywords: [String]
  let reviews: [String]

  let solution: [String]
}

/**
 Problem:

 Given a list of reviews, a list of keywords and an integer k. Find the most popular k keywords in order of most to least frequently mentioned.

 The comparison of strings is case-insensitive. If keywords are mentioned an equal number of times in reviews, sort alphabetically.

 Ref - https://leetcode.com/discuss/interview-question/542597/
 */
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

  private func f
}
