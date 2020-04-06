/**
 Problem

 You have an array of logs. Each log is a space delimited string of words.

 For each log, the first word in each log is an alphanumeric identifier.

 Then, either:
 1. Each word after the identifier will consist only of lowercase letters, or;
 2. Each word after the identifier will consist only of digits.

 We will call these two varieties of logs letter-logs and digit-logs.  It is guaranteed that each log has at least one word after its identifier.

 Reorder the logs so that all of the letter-logs come before any digit-log.  The letter-logs are ordered lexicographically ignoring identifier, with the identifier used in case of ties.  The digit-logs should be put in their original order.

 Return the final order of the logs.

 Example 1:

 Input: logs = ["dig1 8 1 5 1","let1 art can","dig2 3 6","let2 own kit dig","let3 art zero"]
 Output: ["let1 art can","let3 art zero","let2 own kit dig","dig1 8 1 5 1","dig2 3 6"]

 Constraints:

 0 <= logs.length <= 100
 3 <= logs[i].length <= 100
 logs[i] is guaranteed to have an identifier, and a word after the identifier.

 [Ref](https://leetcode.com/problems/reorder-data-in-log-files/)
 */

import Foundation
import XCTest

struct TestCase {
  let logs: [String]
  let solution: [String]
}

final class ReorderDataInLogFilesTests: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(
      logs: ["dig1 8 1 5 1", "let1 art can", "dig2 3 6", "let2 own kit dig", "let3 art zero"],
      solution: ["let1 art can", "let3 art zero", "let2 own kit dig", "dig1 8 1 5 1", "dig2 3 6"]
    ),
    TestCase(
      logs: ["dig1 1"],
      solution: ["dig1 1"]
    ),
    TestCase(
      logs: ["let1 art can"],
      solution: ["let1 art can"]
    ),
    TestCase(
      logs: ["let1 aaaa", "let2 aa", "let3 a"],
      solution: ["let3 a", "let2 aa", "let1 aaaa"]
    ),
    TestCase(
      logs: ["j je", "b fjt", "7 zbr", "m le", "o 33"],
      solution: ["b fjt","j je","m le","7 zbr","o 33"]
    ),
    TestCase(
      logs: ["a1 9 2 3 1","g1 act car","zo4 4 7","ab1 off key dog","a8 act zoo","a2 act car"],
      solution: ["a2 act car","g1 act car","a8 act zoo","ab1 off key dog","a1 9 2 3 1","zo4 4 7"]
    )
  ]

  // 136 ms  22.1 MB
  // faster than 38.67% of Swift online submissions.
  func reorderLogs(logs: [String]) -> [String] {
    var filenames: [String] = [] // letter log filenames.
    var letterLogs: [String] = []
    var digitLogs: [String] = []

    for str in logs {
      let words = str.components(separatedBy: " ")
      let filename = words[0]
      let firstDataWord = words[1]
      let logData = Array(words[1...]).joined(separator: " ")
      let isLetterLog = Array(firstDataWord)[0].isLetter

      var index = 0

      if isLetterLog {
        while !letterLogs.isEmpty, index < letterLogs.count, letterLogs[index] < logData {
          index += 1
        }

        if index == letterLogs.count {
          letterLogs.append(logData)
          filenames.append(filename)
        } else {
          letterLogs.insert(logData, at: index)
          filenames.insert(filename, at: index)
        }
      } else {
        // Digits.
        digitLogs.append(str)
      }
    }

    var mergedLogs: [String] = []

    for i in 0..<filenames.count {
      mergedLogs.append("\(filenames[i]) \(letterLogs[i])")
    }

    return mergedLogs + digitLogs
  }

  func testReorderLogs() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let orderedLogs = reorderLogs(logs: testCase.logs)

      XCTAssert(orderedLogs == solution, "Expected: \(solution) but got: \(orderedLogs) for testCase \(i)")
    }
  }
}
