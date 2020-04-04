import Foundation
import XCTest

/**
 Problem:

 Given a non-empty list of words, return the k most frequent elements.

 Your answer should be sorted by frequency from highest to lowest. If two words have the same frequency,
 then the word with the lower alphabetical order comes first.

 Ex1:
 Input: ["i", "love", "leetcode", "i", "love", "coding"], k = 2
 Output: ["i", "love"]
 Explanation: "i" and "love" are the two most frequent words.
 Note that "i" comes before "love" due to a lower alphabetical order.

 Ex2:
 Input: ["the", "day", "is", "sunny", "the", "the", "the", "sunny", "is", "is"], k = 4
 Output: ["the", "is", "sunny", "day"]
 Explanation: "the", "is", "sunny" and "day" are the four most frequent words,
 with the number of occurrence being 4, 3, 2 and 1 respectively.

 You may assume k is always valid, 1 ≤ k ≤ number of unique elements.
 Input words contain only lowercase letters.

 Try to solve it in O(n log k) time and O(n) extra space.

 Ref - https://leetcode.com/problems/top-k-frequent-words/
 */

struct TestCase {
  let k: Int
  let input: [String]

  let solution: [String]
}

final class TopKFrequentWordsTests: XCTestCase {
  private let testCases: [TestCase] = [
    TestCase(
      k: 2,
      input: ["aaa","aa","a"],
      solution: ["a", "aa"]
    ),
    TestCase(
      k: 3,
      input: ["i", "love", "leetcode", "i", "love", "coding"],
      solution: ["i","love","coding"]
    ),
    TestCase(
      k: 2,
      input: ["i", "love", "leetcode", "i", "love", "coding"],
      solution: ["i", "love"]
    ),
    TestCase(
      k: 1,
      input: ["i", "love", "leetcode", "i", "love", "coding"],
      solution: ["i"]
    ),
    TestCase(
      k: 4,
      input: ["the", "day", "is", "sunny", "the", "the", "the", "sunny", "is", "is"],
      solution: ["the", "is", "sunny", "day"]
    )
  ]

  private func topKFrequent(_ words: [String], _ k: Int) -> [String] {
    assert(k > 0 && k <= words.count)

    var wordCounts: [String: Int] = [:]
    for word in words {
      wordCounts[word, default: 0] += 1
    }

    // No MinHeap in Swift.
    let frequentWords = wordCounts.sorted(by: { d1, d2 -> Bool in
      if d1.value != d2.value {
        return d1.value > d2.value
      } else {
        // Return the word that comes first.
        return d1.key < d2.key
      }
    }).map({ $0.key })

    return Array(frequentWords[0..<k])
  }

  func testTopKFrequent() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let mostFreqWords = topKFrequent(testCase.input, testCase.k)

      XCTAssert(mostFreqWords == solution, "Expected: \(solution) but got: \(mostFreqWords) for testCase \(i)")
    }
  }

  func testHeapPerformance() {
    measure {
      _ = topKFrequent(testCases[1].input, testCases[1].k)
    }
  }
}


TopKFrequentWordsTests.defaultTestSuite.run()
