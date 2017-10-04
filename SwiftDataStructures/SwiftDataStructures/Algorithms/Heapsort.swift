//
//  Heapsort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension Collection {

    func element(at index: Index, within range: Range<Index>? = nil) -> Element? {
        let range = range ?? startIndex ..< endIndex
        return (range ~= index) ? self[index] : nil
    }

}

class BinaryHeap<Value: Comparable> {

    private(set)
    var items: [Value] = []

    init<S: Sequence>(_ items: S) where S.Iterator.Element == Value {
        self.items = Array(items)
        build()
    }

    func leftIndex(for index: Int) -> Int {
        return index * 2 + 1
    }

    func left(for index: Int, range: Range<Int>) -> Value? {
        let leftIndex = self.leftIndex(for: index)
        return items.element(at: leftIndex, within: range)
    }

    func rightIndex(for index: Int) -> Int {
        return index * 2 + 2
    }

    func right(for index: Int, range: Range<Int>) -> Value? {
        let rightIndex = self.rightIndex(for: index)
        return items.element(at: rightIndex, within: range)
    }

    var defaultRange: Range<Int> {
        return items.startIndex ..< items.endIndex
    }

    func heapify(at index: Int, range: Range<Int>? = nil) {
        let range = range ?? defaultRange

        guard var largest = items.element(at: index) else {
            return assertionFailure()
        }

        var largestIndex = index

        if
            let left = self.left(for: index, range: range),
            largest <= left {
            largest = left
            largestIndex = leftIndex(for: index)
        }

        if
            let right = self.right(for: index, range: range),
            largest <= right {
            largest = right
            largestIndex = rightIndex(for: index)
        }

        if largestIndex != index {
            items.swapAt(index, largestIndex)
            heapify(at: largestIndex, range: range)
        }
    }

    func build() {
        for i in (0 ..< items.count / 2).reversed() {
            heapify(at: i)
        }

        checkSelf()
    }

    func checkSelf() {
        if !items.isEmpty {
            check(at: 0)
        }
    }

    func check(at index: Int) {
        guard let value = items.element(at: index) else {
            return assertionFailure()
        }

        if let left = self.left(for: index, range: defaultRange) {
            assert(value >= left)
            check(at: leftIndex(for: index))
        }

        if let right = self.right(for: index, range: defaultRange) {
            assert(value >= right)
            check(at: rightIndex(for: index))
        }
    }

    func exchangeWithRoot(at index: Int, range: Range<Int>) {
        guard
            let max = items.element(at: 0),
            let value = items.element(at: index)
        else {
            return assertionFailure()
        }

        items[0] = value
        heapify(at: 0, range: range)
        items[index] = max
    }

    func sort() {
        for i in (0 ..< items.count).reversed() {
            let range: Range<Int> = 0 ..< i + 1
            exchangeWithRoot(at: i, range: range)
        }
    }

}

extension Array where Element: Comparable {

    public mutating
    func heapsort() {
        let heap = BinaryHeap<Element>(self)
        heap.sort()
        self = heap.items
    }

}
