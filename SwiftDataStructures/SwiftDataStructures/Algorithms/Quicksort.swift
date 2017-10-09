//
//  Quicksort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension MutableCollection where Element: Comparable {

    // MARK: - Public API

    public mutating
    func quicksort(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        startIndex: Index? = nil,
        endIndex: Index? = nil
    ) rethrows {
        let start = startIndex ?? self.startIndex
        let end = endIndex ?? self.endIndex

        guard start < index(before: end) else {
            return
        }

        let pivot = getPivot(startIndex: start, endIndex: end)

        let pivotIndex = try partition(
            by: areInIncreasingOrder,
            pivot: pivot,
            startIndex: start,
            endIndex: end
        )

        try quicksort(by: areInIncreasingOrder, startIndex: start, endIndex: pivotIndex)
        try quicksort(by: areInIncreasingOrder, startIndex: Swift.min(index(after: pivotIndex), end), endIndex: end)
    }

    public
    func quicksorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Self {
        var newCollection = self
        try newCollection.quicksort(by: areInIncreasingOrder)
        return newCollection
    }

    // MARK: - Implementation

    private
    func getPivot(startIndex: Index, endIndex: Index) -> Element {
        return self[index(before: endIndex)]
    }

    private mutating
    func partition(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        pivot: Element,
        startIndex: Index,
        endIndex: Index
    ) rethrows -> Index {
        var i = startIndex
        var j = index(before: endIndex)

        while i < j {
            while try (i < index(before: endIndex) && areInIncreasingOrder(self[i], pivot)) {
                i = index(after: i)
            }

            while try (j > startIndex && !areInIncreasingOrder(self[j], pivot) && self[j] != pivot) {
                j = index(before: j)
            }

            if i < j {
                swapAt(i, j)

                if self[i] == pivot && self[j] == pivot {
                    (i, j) = try partitionElementsBetweenPivots(
                        by: areInIncreasingOrder,
                        pivotIndex1: i,
                        pivotIndex2: j
                    )
                } else {
                    if self[i] != pivot {
                        i = index(after: i)
                    }
                    if self[j] != pivot {
                        j = index(before: j)
                    }
                }
            }
        }

        return i
    }

    private mutating
    func partitionElementsBetweenPivots(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        pivotIndex1: Index,
        pivotIndex2: Index
    ) rethrows -> (Index, Index) {
        assert(self[pivotIndex1] == self[pivotIndex2])
        assert(pivotIndex1 < pivotIndex2)

        let pivot = self[pivotIndex1]

        var i = pivotIndex1
        var j = pivotIndex2

        if abs(distance(from: i, to: j)) <= 1 {
            i = j
        } else {
            let next = index(after: i)
            let prev = index(before: j)
            if next < endIndex, try !areInIncreasingOrder(self[next], pivot), self[next] != pivot {
                i = index(after: i)
            } else if prev >= startIndex, try areInIncreasingOrder(self[prev], pivot) {
                j = index(before: j)
            } else {
                if next < endIndex {
                    swapAt(i, next)
                    i = next
                }
                if prev >= startIndex {
                    swapAt(prev, j)
                    j = prev
                }
            }
        }

        return (i, j)
    }

}
