//
//  Radixsort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension MutableCollection where Element: BinaryInteger {

    public mutating
    func radixsort(
        by areInIncreasingOrder: (Element, Element) throws -> Bool = (<)
    ) rethrows {
        let bitWidth = Element(0).bitWidth
        try radixsort(
            by: areInIncreasingOrder,
            for: bitWidth - 1,
            range: startIndex ..< endIndex
        )
    }

    public
    func radixsorted(
        by areInIncreasingOrder: (Element, Element) throws -> Bool = (<)
    ) rethrows -> Self {
        var newCollection = self
        try newCollection.radixsort(by: areInIncreasingOrder)
        return newCollection
    }

}

private
extension MutableCollection where Element: BinaryInteger {

    mutating
    func radixsort(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        for bitNumber: Int,
        range: Range<Index>
    ) rethrows {
        guard distance(from: range.lowerBound, to: range.upperBound) > 1 else {
            return
        }

        var i = range.lowerBound
        var j = index(before: range.upperBound)

        let isAscending = try areInIncreasingOrder(0, 1)
        while i <= j {
            while i <= j && self[i].bitIsOne(by: bitNumber) == !isAscending {
                i = index(after: i)
            }

            while i <= j && self[j].bitIsOne(by: bitNumber) == isAscending {
                j = index(before: j)
            }

            if i < j {
                swapAt(i, j)
            }
        }

        if bitNumber >= 1 {
            try radixsort(
                by: areInIncreasingOrder,
                for: bitNumber - 1,
                range: range.lowerBound ..< i
            )
            try radixsort(
                by: areInIncreasingOrder,
                for: bitNumber - 1,
                range: i ..< range.upperBound
            )
        }
    }

}

private
extension BinaryInteger {

    func bitIsOne(by index: Int) -> Bool {
        let mask = Self(1 << index)
        return (self & mask) != 0
    }

}
