/**
 Problem:

 Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.

 Note:

 The number of elements initialized in nums1 and nums2 are m and n respectively.
 You may assume that nums1 has enough space (size that is greater or equal to m + n) to hold additional elements from nums2.
 Example:

 Input:
 nums1 = [1,2,3,0,0,0], m = 3
 nums2 = [2,5,6],       n = 3

 Output: [1,2,2,3,5,6]

 [Ref](https://leetcode.com/problems/merge-sorted-array/)
 */

class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if nums1.isEmpty {
            nums1 = nums2
            return
        }

        if nums2.isEmpty { return }

        var nums2 = nums2 // mutable copy
        var m = m
        var insertIndex = 0

        while !nums2.isEmpty {
            var firstNum = nums1[insertIndex]
            let secondNum = nums2.removeFirst()

            while firstNum < secondNum, insertIndex < m {
                insertIndex += 1
                firstNum = nums1[insertIndex]
            }

            if insertIndex == m {
                nums1[insertIndex] = secondNum

                // Add the rest
                for i in 0..<nums2.count {
                    insertIndex += 1
                    nums1[insertIndex] = nums2[i]
                }
            }

            // we need to insert this number and remove one from the end.
            nums1.insert(secondNum, at: insertIndex)
            nums1.removeLast()
            m += 1
        }
    }
}
