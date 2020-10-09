import XCTest


final class Solution: XCTestCase {

  private struct TestCase {
    let input: String
    let rows: Int
    let output: String
  }

  private let testCases: [TestCase] = [
    TestCase(
      input: "PAYPALISHIRING",
      rows: 3,
      output: "PAHNAPLSIIGYIR"
    )
  ]

  /*
   Runtime: 52 ms, faster than 87.04% of Swift online submissions for ZigZag Conversion.
   Memory Usage: 14.5 MB, less than 27.16% of Swift online submissions for ZigZag Conversion.
   */
  func convert(_ s: String, _ numRows: Int) -> String {
    // The solution is `numRows` strings join together in order.
    // We can create this by iterating over the string and adding each characther to the correct string.
    // We then return these strings joined in row order.

    guard numRows != 1 else { return s }

    var currentRow: Int = 0
    var goingDown: Bool = true // means we are moving down in the 2d array in the example.
    var rowStrings: [String] = []

    for _ in 0..<numRows {
      rowStrings.append("")
    }

    for char in Array(s) {
      rowStrings[currentRow] += String(char)

      currentRow += goingDown ? 1 : -1

      if currentRow == numRows {
        currentRow = numRows - 2
        goingDown = false
      } else if currentRow < 0 {
        currentRow = 1
        goingDown = true
      }
    }


    return rowStrings.joined(separator: "")
  }

  func testConvert() {
    for (index, testCase) in testCases.enumerated() {
      let result = convert(testCase.input, testCase.rows)
      XCTAssertEqual(testCase.output, result, "Expected: \(testCase.output), but got \(result) for test case \(index)")
    }
  }
}

Solution.defaultTestSuite.run()
