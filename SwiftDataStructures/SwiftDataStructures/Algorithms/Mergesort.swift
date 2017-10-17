//
//  Mergesort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension MutableCollection where Element: Comparable {

    public mutating
    func mergesort(
        by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool,
        range: Range<Index>? = nil
    ) rethrows {
        let range = range ?? startIndex ..< endIndex
        let count = distance(from: range.lowerBound, to: range.upperBound)

        guard count > 1 else {
            return
        }

        let medianIndex = index(range.lowerBound, offsetBy: count / 2)
        let firstRange = range.lowerBound ..< medianIndex
        let secondRange = medianIndex ..< range.upperBound

        try mergesort(by: areInIncreasingOrder, range: firstRange)
        try mergesort(by: areInIncreasingOrder, range: secondRange)
        try merge(by: areInIncreasingOrder, firstRange, secondRange)
    }

    public
    func mergesorted(by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool) rethrows -> Self {
        var newCollection = self
        try newCollection.mergesort(by: areInIncreasingOrder)
        return newCollection
    }

}

private
extension MutableCollection {

    mutating
    func merge(
        by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool,
        _ range1: Range<Index>,
        _ range2: Range<Index>
    ) rethrows {
        assert(!range1.isEmpty)
        assert(!range2.isEmpty)

        var index1 = range1.lowerBound
        var index2 = range2.lowerBound

        var mergedArray: [Element] = []
        while true {
            if try areInIncreasingOrder(self[index1], self[index2]) {
                mergedArray.append(pop(from: &index1))
                if index1 == range1.upperBound {
                    mergedArray.append(contentsOf: self[index2 ..< range2.upperBound])
                    break
                }
            } else {
                mergedArray.append(pop(from: &index2))
                if index2 == range2.upperBound {
                    mergedArray.append(contentsOf: self[index1 ..< range1.upperBound])
                    break
                }
            }
        }

        rewrite(with: mergedArray, range: range1.lowerBound ..< range2.upperBound)
    }

    func pop(from index: inout Index) -> Element {
        let element = self[index]
        index = self.index(after: index)
        return element
    }

}
