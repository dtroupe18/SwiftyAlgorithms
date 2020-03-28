import Foundation
import XCTest

struct TestCase {
  let testString: String
  let solution: Bool
}

public struct Stack<T> {
  private var array: [T] = []

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public mutating func push(_ element: T) {
    array.append(element)
  }

  public mutating func pop() -> T? {
    return array.popLast()
  }

  public func peek() -> T? {
    return array.last
  }
}

final class ValidParenthesesTests: XCTestCase {
  private let testCases: [TestCase] = [
    TestCase(testString: "()", solution: true),
    TestCase(testString: "()[]{}", solution: true),
    TestCase(testString: "(]", solution: false),
    TestCase(testString: "([)]", solution: false),
    TestCase(testString: "{[]}", solution: true),
    TestCase(testString: "{[()]}", solution: true),
    TestCase(testString: "{[(])}", solution: false),
    TestCase(testString: "{{[[(())]]}}", solution: true),
    TestCase(testString: "", solution: true),
    TestCase(testString: "}", solution: false),
  ]

  func checkIfParenthesesAreBalanced(_ parentheses: String) -> Bool {
    var stack = Stack<Character>()

    let parentheseDict: [Character: Character] = [
      ")": "(",
      "}": "{",
      "]": "["
    ]

    let closing = parentheseDict.keys

    for parenthese in parentheses {
      if closing.contains(parenthese) {
        guard let opening = stack.pop() else { return false }
        guard opening == parentheseDict[parenthese] else { return false }
      } else {
        stack.push(parenthese)
      }
    }

    return stack.isEmpty
  }

  func testCheckIfParenthesesAreBalanced() {
    for (i, testCase) in testCases.enumerated() {
      let result = checkIfParenthesesAreBalanced(testCase.testString)

      XCTAssert(
        result == testCase.solution,
        "Expected \(testCase.solution), but got \(result) for test case \(i)"
      )
    }
  }
}

ValidParenthesesTests.defaultTestSuite.run()
