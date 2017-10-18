//
//  Selectionsort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension MutableCollection {

    public mutating
    func selectionsort(
        comparingBy areInIncreasingOrder: @escaping (Element, Element) throws -> Bool
    ) rethrows {
        var i = startIndex
        while i != endIndex {
            let extrIndex = try indexOfExtremum(by: areInIncreasingOrder, range: i ..< endIndex)
            swapAt(i, extrIndex)
            i = index(after: i)
        }
    }

    public
    func selectionsorted(
        comparingBy areInIncreasingOrder: @escaping (Element, Element) throws -> Bool
    ) rethrows -> Self {
        var newCollection = self
        try newCollection.selectionsort(comparingBy: areInIncreasingOrder)
        return newCollection
    }

}

extension MutableCollection where Element: Comparable {

    public mutating
    func selectionsort(
        by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool = (<)
    ) rethrows {
        try selectionsort(comparingBy: areInIncreasingOrder)
    }

    public
    func selectionsorted(
        by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool = (<)
    ) rethrows -> Self {
        return try selectionsorted(comparingBy: areInIncreasingOrder)
    }

}

private
extension MutableCollection {

    func indexOfExtremum(
        by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool,
        range: Range<Index>
    ) rethrows -> Index {
        var minIndex = range.lowerBound
        var i = range.lowerBound
        while i != range.upperBound {
            if try areInIncreasingOrder(self[i], self[minIndex]) {
                minIndex = i
            }
            i = index(after: i)
        }
        return minIndex
    }

}
