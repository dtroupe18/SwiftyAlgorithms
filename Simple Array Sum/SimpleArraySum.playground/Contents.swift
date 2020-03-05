import Foundation
import XCTest

typealias SumFunction = () -> Int

final class SimpleArraySumTests: XCTestCase {
    private let testCases: [[Int]] = [
        [1],
        [1, 2, 3, 4, 10, 11],
        [1, 1, 1, 10, 10]
    ]

    private let solutions: [Int] = [1, 31, 23]

    // MARK: Performance
    lazy var largeArray: [Int] = {
        return self.makeRandomIntArray(length: 500, minValue: 0, maxValue: 1000)
    }()

    lazy var largerArray: [Int] = {
        return self.makeRandomIntArray(length: 1000, minValue: 0, maxValue: 1000)
    }()

    override func setUp() {
        super.setUp()
    }

    override class func tearDown() {
        super.tearDown()
    }

    func reduceMethod(array: [Int]) -> Int {
        return array.reduce(0, +)
    }

    func simpleSum(array: [Int]) -> Int {
        var sum: Int = 0
        array.forEach { sum += $0 }

        return sum
    }

    func makeRandomIntArray(length: Int, minValue: Int, maxValue: Int) -> [Int] {
        return (0..<length).map{ _ in Int.random(in: minValue ... maxValue) }
    }

    func testSumMethods() {
        for (index, testCase) in self.testCases.enumerated() {
            XCTAssertTrue(reduceMethod(array: testCase) == solutions[index], "Failed for reduce method")
            XCTAssertTrue(simpleSum(array: testCase) == solutions[index], "Failed for simpleSum method")
        }
    }

    func testForEachLoop() {
        measure {
            // measured [Time, seconds] average: 0.023,
            // relative standard deviation: 143.565%,
            // values: [0.122559, 0.012267, 0.011900, 0.011875, 0.012098, 0.012277, 0.011796, 0.012028, 0.012325, 0.011818]
            _ = simpleSum(array: self.largerArray)
        }
    }

    func testForReduce() {
        measure {
            //  measured [Time, seconds] average: 0.002,
            //  relative standard deviation: 238.800%,
            //  values: [0.015079, 0.000387, 0.000411, 0.000373, 0.000402, 0.000429, 0.000344, 0.000340, 0.000368, 0.000339]
            _ = reduceMethod(array: self.largerArray)
        }
    }
}

SimpleArraySumTests.defaultTestSuite.run()
