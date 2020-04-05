/**
 Problem

 You are given an undirected connected graph. An articulation point (or cut vertex) is defined as a vertex which, when removed along with associated edges, makes the graph disconnected (or more precisely, increases the number of connected components in the graph). The task is to find all articulation points in the given graph.

 Input:

 The input to the function/method consists of three arguments:

 numNodes, an integer representing the number of nodes in the graph.
 numEdges, an integer representing the number of edges in the graph.
 edges, the list of pair of integers - A, B representing an edge between the nodes A and B.

 Output:

 Return a list of integers representing the critical nodes.

 Example 1:

 Input:

 numNodes = 7,
 numEdges = 7,
 edges = [[0, 1], [0, 2], [1, 3], [2, 3], [2, 5], [5, 6], [3, 4]]

           4
          /
         3
        / \
       1   2
        \ / \
         0   5
              \
               6

 Output: [2, 3, 5]


 Example 2:

 numNodes = 5,
 numEdges = 5,
 edges = [[1, 2], [0, 1], [2, 0], [0, 3], [3, 4]]

           0 -- 3
          / \    \
         1 - 2    4

 Output: [0, 3]

 [Ref](https://leetcode.com/discuss/interview-question/436073/)
 */

import Foundation
import XCTest

struct TestCase {
  let nodeCount: Int
  let edgeCount: Int
  let edges: [[Int]]
  let solution: [Int]
}

final class FindCriticalRoutersTests: XCTestCase {
  let testCases: [TestCase] = [
    TestCase(
      nodeCount: 7,
      edgeCount: 7,
      edges: [[0, 1], [0, 2], [1, 3], [2, 3], [2, 5], [5, 6], [3, 4]],
      solution: [2, 3, 5]
    ),
    TestCase(
      nodeCount: 5,
      edgeCount: 5,
      edges: [[1, 2], [0, 1], [2, 0], [0, 3], [3, 4]],
      solution: [0, 3]
    ),
    TestCase(
      nodeCount: 5,
      edgeCount: 4,
      edges: [[1, 2], [0, 1], [2, 0], [0, 3], [3, 4]],
      solution: [0, 3]
    ),
    TestCase(
      nodeCount: 7,
      edgeCount: 8,
      edges: [[0, 1], [0, 2], [1, 2], [1, 3], [1, 4], [1, 6], [3, 5], [4, 5]],
      solution: [1]
    )
  ]

  /**
   Brute force approach - this gives O(verticies * (verticies + edges)). This is because
   for each edge we perform depth first search which is O(V + E).

   Graph construction is O(nodeCount + edgeCount).
   */
  func findCriticalRouters(_ nodeCount: Int, _ edgeCount: Int, _ edges: [[Int]]) -> [Int] {
    // Construct a Graph [NodeNumber: Set(Neighbors)].
    var graph: [Int: Set<Int>] = [:]

    // Add the nodes first.
    for i in 0..<nodeCount {
      graph[i] = Set([])
    }

    // Add edges (neighbors).
    for edge in edges {
      guard edge.count == 2 else { continue }

      graph[edge[0]]!.insert(edge[1])
      graph[edge[1]]!.insert(edge[0])
    }

    var criticalNodes: [Int] = []

    for i in 0..<nodeCount {
      // Remove a node, then perform DFS over the graph. If we reach every node then
      // that router is not critical. Note there is a more efficent method of using a DFS tree,
      // but I don't think you could realistically implement that on a test.

      let neighbors = graph[i]!
      var sourceNode: Int = 0

      for neighbor in neighbors {
        graph[neighbor]!.remove(i)

        // You could start anywhere, but starting at a node that lost
        // edges increases the likelyhood that DFS will fail sooner, if the node
        // is critical.
        sourceNode = neighbor
      }

      var visited = Set<Int>()
      depthFirstSearch(graph: graph, source: sourceNode, visited: &visited)

      // Did we traverse the whole graph.
      if visited.count != nodeCount - 1 {
        criticalNodes.append(i)
      }

      // Restore the graph.
      neighbors.forEach { graph[$0]!.insert(i) }
    }

    return criticalNodes
  }

  func depthFirstSearch(graph: [Int: Set<Int>], source: Int, visited: inout Set<Int>) {
    guard !visited.contains(source) else { return }

    visited.insert(source)
    for neighbor in graph[source]! {
      depthFirstSearch(graph: graph, source: neighbor, visited: &visited)
    }
  }

  func testFindCriticalRouters() {
    for (i, testCase) in testCases.enumerated() {
      let solution = testCase.solution
      let criticalNodes = findCriticalRouters(testCase.nodeCount, testCase.edgeCount, testCase.edges)

      XCTAssert(criticalNodes == solution, "Expected: \(solution) but got: \(criticalNodes) for testCase \(i)")
    }
  }
}

FindCriticalRoutersTests.defaultTestSuite.run()
