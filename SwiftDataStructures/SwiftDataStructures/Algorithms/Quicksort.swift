//
//  Quicksort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

// MARK: - Public API

extension MutableCollection {

    public mutating
    func quicksort(
        comparingBy areInIncreasingOrder: (Element, Element) throws -> Bool,
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

        try quicksort(
            comparingBy: areInIncreasingOrder,
            startIndex: start,
            endIndex: pivotIndex
        )
        try quicksort(
            comparingBy: areInIncreasingOrder,
            startIndex: Swift.min(index(after: pivotIndex), end),
            endIndex: end
        )
    }

    public
    func quicksorted(comparingBy areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Self {
        var newCollection = self
        try newCollection.quicksort(comparingBy: areInIncreasingOrder)
        return newCollection
    }

}

extension MutableCollection where Element: Comparable {

    public mutating
    func quicksort(
        by areInIncreasingOrder: (Element, Element) throws -> Bool = (<),
        startIndex: Index? = nil,
        endIndex: Index? = nil
    ) rethrows {
        try quicksort(
            comparingBy: areInIncreasingOrder,
            startIndex: startIndex,
            endIndex: endIndex
        )
    }

    public
    func quicksorted(
        by areInIncreasingOrder: (Element, Element) throws -> Bool = (<)
    ) rethrows -> Self {
        return try quicksorted(comparingBy: areInIncreasingOrder)
    }

}

// MARK: - Implementation

private
extension MutableCollection {

    func notOrdered(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        _ element1: Element,
        _ element2: Element
    ) rethrows -> Bool {
        return try !areInIncreasingOrder(element1, element2) && !areInIncreasingOrder(element2, element1)
    }

    func ordered(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        _ element1: Element,
        _ element2: Element
    ) rethrows -> Bool {
        return try !notOrdered(by: areInIncreasingOrder, element1, element2)
    }

    func getPivot(startIndex: Index, endIndex: Index) -> Element {
        return self[index(before: endIndex)]
    }

    mutating
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

            while try (j > startIndex && areInIncreasingOrder(pivot, self[j])) {
                j = index(before: j)
            }

            if i < j {
                swapAt(i, j)

                if
                    try notOrdered(by: areInIncreasingOrder, self[i], pivot),
                    try notOrdered(by: areInIncreasingOrder, self[j], pivot) {
                    (i, j) = try partitionElementsBetweenPivots(
                        by: areInIncreasingOrder,
                        pivotIndex1: i,
                        pivotIndex2: j
                    )
                } else {
                    if try ordered(by: areInIncreasingOrder, self[i], pivot) {
                        i = index(after: i)
                    }
                    if try ordered(by: areInIncreasingOrder, self[j], pivot) {
                        j = index(before: j)
                    }
                }
            }
        }

        return i
    }

    mutating
    func partitionElementsBetweenPivots(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        pivotIndex1: Index,
        pivotIndex2: Index
    ) rethrows -> (Index, Index) {
        let notOrdered = try self.notOrdered(by: areInIncreasingOrder, self[pivotIndex1], self[pivotIndex2])
        assert(notOrdered)
        assert(pivotIndex1 < pivotIndex2)

        let pivot = self[pivotIndex1]

        var i = pivotIndex1
        var j = pivotIndex2

        if abs(distance(from: i, to: j)) <= 1 {
            i = j
        } else {
            let next = index(after: i)
            let prev = index(before: j)
            if next < endIndex, try areInIncreasingOrder(pivot, self[next]) {
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
