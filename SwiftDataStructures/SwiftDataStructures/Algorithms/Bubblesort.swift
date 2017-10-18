//
//  Bubblesort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension MutableCollection {

    public mutating
    func bubblesort(
        comparingBy areInIncreasingOrder: @escaping (Element, Element) throws -> Bool
    ) rethrows {
        var wasChanged: Bool

        repeat {
            wasChanged = false
            var index = startIndex

            while index != self.index(before: endIndex) {
                let nextIndex = self.index(after: index)
                let element = self[index]
                let nextElement = self[nextIndex]
                if try areInIncreasingOrder(nextElement, element) {
                    swapAt(index, nextIndex)
                    wasChanged = true
                }

                index = nextIndex
            }
        } while wasChanged
    }

    public
    func bubblesorted(
        comparingBy areInIncreasingOrder: @escaping (Element, Element) throws -> Bool
    ) rethrows -> Self {
        var newCollection = self
        try newCollection.bubblesort(comparingBy: areInIncreasingOrder)
        return newCollection
    }

}

extension MutableCollection where Element: Comparable {

    public mutating
    func bubblesort(
        by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool = (<)
    ) rethrows {
        try bubblesort(comparingBy: areInIncreasingOrder)
    }

    public
    func bubblesorted(
        by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool = (<)
    ) rethrows -> Self {
        return try bubblesorted(comparingBy: areInIncreasingOrder)
    }

}
