import Foundation
import XCTest

private extension Int {
  var cubed: Int {
    return self * self * self
  }
}

struct Solution: CustomStringConvertible {
  let a, b, c, d: Int

  var description: String {
    return "a: \(a), b: \(b), c: \(c), d: \(d)"
  }
}

/**
  Problem statement: Find all positive integer solutions to the equation `a3 + b3 = c3 + d3`
  where `a`, `b`,  `c`, and `d` are integers between `1` and `100`.
*/

final class EqualCubeSumTests: XCTestCase {
  /**
   Brute force method O(n^4).
   if n = 100 this will need to perform 100 million loops.
   if n = 1000 this will need to perform 1 trillion loops.
   */
  func findSolutionsBruteForce() -> [Solution] {
    var solutions: [Solution] = []
    let n: Int = 50

    for a in 1...n {
      for b in 1...n {
        for c in 1...n {
          for d in 1...n {
            if a.cubed + b.cubed == c.cubed + d.cubed {
              // Note: We can break out of the d loop here because
              // there is only one possible value as a solution. This however,
              // does nothing to reduce the overal complexity, but it still helps.
              solutions.append(Solution(a: a, b: b, c: c, d: d))
              break
            }
          }
        }
      }
    }

    return solutions
  }

  /**
   Cube root method O(n^3)

   If we do a little algebra we can solve for any variable above.
   Ex: d^3 = a^3 + b^3 - c^3
   Ex: d = (a^3 + b^3 - c^3)^(1/3).
   */
  func findSolutionsCubeRoot() -> [Solution] {
    var solutions: [Solution] = []
    let n: Int = 100

    for a in 1...n {
      for b in 1...n {
        for c in 1...n {
          let dDouble = pow(Double(a.cubed + b.cubed - c.cubed), 1.0/3.0)

          // NAN and Infinity cannot be converted to Int.
          if dDouble.isFinite {
            let d = Int(dDouble)

            if a.cubed + b.cubed == c.cubed + d.cubed {
              solutions.append(Solution(a: a, b: b, c: c, d: d))
            }
          }
        }
      }
    }

    return solutions
  }

  /**
   Dictionary(HashMap) method O(n^2)

   The trick here is to avoid repeating work. We should just create the list of
   (c, d) pairs once. Then use those pairs directly to find the solutions.

   Also need notice that in order for a^3 + b^3 to equal c^3 + d^3
   c^3 == a^3 || b^3 and d^3 = a^3 || b^3.

   Ex: 3^3 + 4^3 = 4^3 + 3^3
   */
  func findSolutionsDictionary() -> [Solution] {
    // Conform to Hashable so we can use this as a dictionary key.
    struct Pair: Hashable, CustomStringConvertible {
      let c: Int
      let d: Int

      var description: String {
        return "(\(c), \(d))"
      }

      func hash(into hasher: inout Hasher) {
        hasher.combine(c)
        hasher.combine(d)
      }

      static func ==(lhs: Pair, rhs: Pair) -> Bool {
        return lhs.c == rhs.c && lhs.d == rhs.d
      }
    }

    var solutions: [Solution] = []
    var dict: [Int: [Pair]] = [:]
    let n: Int = 1000

    for c in 1...n {
      for d in 1...n {
        let result = c.cubed + d.cubed
        dict[result, default: []].append(Pair(c: c, d: d))
      }
    }

    for (_, pairArray) in dict {
      for pair1 in pairArray {
        for pair2 in pairArray {
          solutions.append(Solution(a: pair1.c, b: pair1.d, c: pair2.c, d: pair2.d))
        }
      }
    }

    return solutions
  }

  // MARK: Performance

  /*
   If you run then all at once it can take a significant amount of time.
   Also these tests run faster in a standard Xcode project. I think some
   of the Playground overhead (like counting the number of calls really slows things down).
  */

  func testPerformanceForBruteForce() {
    // With n = 50
    // measured [Time, seconds] average: 3.771
    // relative standard deviation: 0.701%
    // values: [3.814362, 3.770861, 3.805630, 3.802247, 3.773842, 3.748335, 3.763935, 3.740092, 3.740625, 3.749189]
    measure {
      _ = self.findSolutionsBruteForce()
    }
  }

  func testFindSolutionCubeRoot() {
    // With n = 250
    // measured [Time, seconds] average: 9.797
    // relative standard deviation: 0.300%
    // values: [9.847727, 9.782082, 9.812261, 9.770140, 9.772448, 9.780087, 9.827577, 9.837534, 9.772566, 9.768248]
    measure {
      _ = self.findSolutionsCubeRoot()
    }
  }

  func testFindSolutionsDict() {
    // With n = 1000
    // measured [Time, seconds] average: 2.933
    // relative standard deviation: 1.354%
    // values: [3.010284, 2.979897, 2.908594, 2.906194, 2.929836, 2.977788, 2.880059, 2.914529, 2.902005, 2.920172]
    measure {
      _ = self.findSolutionsDictionary()
    }
  }
}

EqualCubeSumTests.defaultTestSuite.run()
