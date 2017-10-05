//
//  Heapsort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

// MARK: - Heapsort

extension MutableCollection where Element: Comparable {

    public mutating
    func heapsort(by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool) rethrows {
        let heap = BinaryHeap<Element>(self)
        try heap.build(by: areInIncreasingOrder)
        try heap.sort(by: areInIncreasingOrder)

        rewriteWith(heap.items)
    }

    public
    func heapsorted(
        by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool
    ) rethrows -> Self {
        var newCollection = self
        try newCollection.heapsort(by: areInIncreasingOrder)
        return newCollection
    }

}

// MARK: - Implementation

private
extension MutableCollection where Element: Comparable {

    mutating
    func rewriteWith(_ items: [Element]) {
        var index = startIndex
        for i in 0 ..< items.count {
            self[index] = items[i]
            index = self.index(after: index)
        }
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
class BinaryHeap<Value: Comparable> {

    // MARK: Properties

    private(set)
    var items: [Value] = []

    private
    var defaultRange: Range<Int> {
        return items.startIndex ..< items.endIndex
    }

    // MARK: Initialization

    init<S: Sequence>(_ items: S) where S.Iterator.Element == Value {
        self.items = Array(items)
    }

    // MARK: File Level API

    fileprivate
    func build(by areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows {
        for i in (0 ..< items.count / 2).reversed() {
            try heapify(by: areInIncreasingOrder, at: i)
        }

        try checkSelf(by: areInIncreasingOrder)
    }

    fileprivate
    func sort(by areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows {
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
    func left(for index: Int, range: Range<Int>) -> Value? {
        let leftIndex = self.leftIndex(for: index)
        return items.element(at: leftIndex, within: range)
    }

    private
    func rightIndex(for index: Int) -> Int {
        return index * 2 + 2
    }

    private
    func right(for index: Int, range: Range<Int>) -> Value? {
        let rightIndex = self.rightIndex(for: index)
        return items.element(at: rightIndex, within: range)
    }

    private
    func heapify(
        by areInIncreasingOrder: (Value, Value) throws -> Bool,
        at index: Int,
        range: Range<Int>? = nil
    ) rethrows {
        let range = range ?? defaultRange

        guard var largest = items.element(at: index) else {
            return assertionFailure()
        }

        var largestIndex = index

        if
            let left = self.left(for: index, range: range),
            try areInIncreasingOrder(largest, left) {
            largest = left
            largestIndex = leftIndex(for: index)
        }

        if
            let right = self.right(for: index, range: range),
            try areInIncreasingOrder(largest, right) {
            largest = right
            largestIndex = rightIndex(for: index)
        }

        if largestIndex != index {
            items.swapAt(index, largestIndex)
            try heapify(by: areInIncreasingOrder, at: largestIndex, range: range)
        }
    }

    private
    func checkSelf(by areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows {
        if !items.isEmpty {
            try check(by: areInIncreasingOrder, at: 0)
        }
    }

    private
    func check(by areInIncreasingOrder: (Value, Value) throws -> Bool, at index: Int) rethrows {
        guard let value = items.element(at: index) else {
            return assertionFailure()
        }

        if let left = self.left(for: index, range: defaultRange), left != value {
            let isLeftLess = try areInIncreasingOrder(left, value)
            assert(isLeftLess)
            try check(by: areInIncreasingOrder, at: leftIndex(for: index))
        }

        if let right = self.right(for: index, range: defaultRange), right != value {
            let isRightLess = try areInIncreasingOrder(right, value)
            assert(isRightLess)
            try check(by: areInIncreasingOrder, at: rightIndex(for: index))
        }
    }

    private
    func exchangeWithRoot(
        by areInIncreasingOrder: (Value, Value) throws -> Bool,
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
