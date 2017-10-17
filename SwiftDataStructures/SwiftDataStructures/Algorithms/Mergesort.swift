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

        let middleIndex = index(range.lowerBound, offsetBy: count / 2)

        let firstRange = range.lowerBound ..< middleIndex
        try mergesort(by: areInIncreasingOrder, range: firstRange)

        let secondRange = middleIndex ..< range.upperBound
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
        _ firstRange: Range<Index>,
        _ secondRange: Range<Index>
    ) rethrows {
        assert(!firstRange.isEmpty)
        assert(!secondRange.isEmpty)

        var first = firstRange.lowerBound
        var second = secondRange.lowerBound

        var mergedArray: [Element] = []
        while true {
            if try areInIncreasingOrder(self[first], self[second]) {
                mergedArray.append(self[first])
                first = index(after: first)
                if first == firstRange.upperBound {
                    mergedArray.append(contentsOf: self[second ..< secondRange.upperBound])
                    break
                }
            } else {
                mergedArray.append(self[second])
                second = index(after: second)
                if second == secondRange.upperBound {
                    mergedArray.append(contentsOf: self[first ..< firstRange.upperBound])
                    break
                }
            }
        }

        let lowerBound = Swift.min(firstRange.lowerBound, secondRange.lowerBound)
        let upperBound = Swift.max(firstRange.upperBound, secondRange.upperBound)
        rewrite(with: mergedArray, range: lowerBound ..< upperBound)
    }

}
