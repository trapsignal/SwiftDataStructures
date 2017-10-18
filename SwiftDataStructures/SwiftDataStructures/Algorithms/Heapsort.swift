//
//  Heapsort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

// MARK: - Heapsort

extension MutableCollection {

    public mutating
    func heapsort(comparingBy areInIncreasingOrder: @escaping (Element, Element) throws -> Bool) rethrows {
        let heap = BinaryHeap<Element>(self)
        try heap.build(by: areInIncreasingOrder)
        try heap.sort(by: areInIncreasingOrder)

        rewrite(with: heap.items)
    }

    public
    func heapsorted(
        comparingBy areInIncreasingOrder: @escaping (Element, Element) throws -> Bool
    ) rethrows -> Self {
        var newCollection = self
        try newCollection.heapsort(comparingBy: areInIncreasingOrder)
        return newCollection
    }

}

extension MutableCollection where Element: Comparable {

    public mutating
    func heapsort(
        by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool = (<)
    ) rethrows {
        try heapsort(comparingBy: areInIncreasingOrder)
    }

    public
    func heapsorted(
        by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool = (<)
    ) rethrows -> Self {
        return try heapsorted(comparingBy: areInIncreasingOrder)
    }

}

private
extension Collection {

    func element(at index: Index, within range: Range<Index>? = nil) -> Element? {
        let range = range ?? startIndex ..< endIndex
        return (range ~= index) ? self[index] : nil
    }

}

// MARK: - BinaryHeap

private
class BinaryHeap<Element> {

    // MARK: Properties

    private(set)
    var items: [Element] = []

    private
    var defaultRange: Range<Int> {
        return items.startIndex ..< items.endIndex
    }

    // MARK: Initialization

    init<S: Sequence>(_ items: S) where S.Iterator.Element == Element {
        self.items = Array(items)
    }

    // MARK: File Level API

    fileprivate
    func build(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        for i in (0 ..< items.count / 2).reversed() {
            try heapify(by: areInIncreasingOrder, at: i)
        }

        try checkSelf(by: areInIncreasingOrder)
    }

    fileprivate
    func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        for i in (0 ..< items.count).reversed() {
            let range: Range<Int> = 0 ..< i + 1
            try exchangeWithRoot(by: areInIncreasingOrder, at: i, range: range)
        }
    }

    // MARK: Implementation

    private
    func leftIndex(for index: Int) -> Int {
        return index * 2 + 1
    }

    private
    func left(for index: Int, range: Range<Int>) -> Element? {
        let leftIndex = self.leftIndex(for: index)
        return items.element(at: leftIndex, within: range)
    }

    private
    func rightIndex(for index: Int) -> Int {
        return index * 2 + 2
    }

    private
    func right(for index: Int, range: Range<Int>) -> Element? {
        let rightIndex = self.rightIndex(for: index)
        return items.element(at: rightIndex, within: range)
    }

    private
    func heapify(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        at index: Int,
        range: Range<Int>? = nil
    ) rethrows {
        let range = range ?? defaultRange

        let largestIndex = try [
            (index, items.element(at: index)),
            (leftIndex(for: index), left(for: index, range: range)),
            (rightIndex(for: index), right(for: index, range: range))
        ]
            .flatMap { pair in pair.1.map { item in (pair.0, item) } }
            .max { try areInIncreasingOrder($0.1, $1.1) }?
            .0

        if let largestIndex = largestIndex, largestIndex != index {
            items.swapAt(index, largestIndex)
            try heapify(by: areInIncreasingOrder, at: largestIndex, range: range)
        }
    }

    private
    func checkSelf(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        if !items.isEmpty {
            try check(by: areInIncreasingOrder, at: 0)
        }
    }

    private
    func check(by areInIncreasingOrder: (Element, Element) throws -> Bool, at index: Int) rethrows {
        guard let value = items.element(at: index) else {
            return assertionFailure()
        }

        try [
            (leftIndex(for: index), left(for: index, range: defaultRange)),
            (rightIndex(for: index), right(for: index, range: defaultRange))
        ]
            .flatMap { pair in pair.1.map { item in (pair.0, item) } }
            .forEach { pair in
                let isLessOrNotOrdered = try areInIncreasingOrder(pair.1, value) || !areInIncreasingOrder(value, pair.1)
                assert(isLessOrNotOrdered)
                try check(by: areInIncreasingOrder, at: pair.0)
            }
    }

    private
    func exchangeWithRoot(
        by areInIncreasingOrder: (Element, Element) throws -> Bool,
        at index: Int,
        range: Range<Int>
    ) rethrows {
        guard
            let max = items.element(at: 0),
            let value = items.element(at: index)
        else {
            return assertionFailure()
        }

        items[0] = value
        try heapify(by: areInIncreasingOrder, at: 0, range: range)
        items[index] = max
    }

}
