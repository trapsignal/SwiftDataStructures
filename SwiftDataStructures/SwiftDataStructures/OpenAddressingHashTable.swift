//
//  OpenAddressingHashTable.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

// MARK: - OpenAddressingHashTable

struct OpenAddressingHashTable<Value: Hashable>: HashTable {

    // MARK: Types

    typealias Probing = (_ hashValue: Int, _ hashTableCapacity: Int) -> AnySequence<Int>

    private
    typealias This = OpenAddressingHashTable<Value>

    private
    struct Item {

        let value: Value
        var isDeleted: Bool

        init(value: Value, isDeleted: Bool = false) {
            self.value = value
            self.isDeleted = isDeleted
        }

    }

    private
    struct ValueSequence: Sequence, IteratorProtocol {

        private
        let iterator: AnyIterator<Int>

        private
        let hashTable: [Item?]

        init<S>(indices: S, hashTable: [Item?])
            where
                S: Sequence,
                S.SubSequence: Sequence,
                S.Iterator.Element == Int,
                S.SubSequence.SubSequence == S.SubSequence,
                S.SubSequence.Iterator.Element == Int {
            self.iterator = AnyIterator(indices.makeIterator())
            self.hashTable = hashTable
        }

        mutating
        func next() -> Value? {
            guard
                let index = iterator.next(),
                index < hashTable.count,
                let item = hashTable[index]
            else {
                return nil
            }

            return !item.isDeleted ? item.value : next()
        }

    }

    // MARK: Properties

    static var initialHashTableCapacity: Int {
        return 4
    }

    var hashTableCapacity = initialHashTableCapacity

    var count: Int {
        return hashTable.flatMap { $0 }.filter { !$0.isDeleted }.count
    }

    private
    var hashTable: [Item?] = []

    private
    let probing: Probing

    // MARK: Initialization

    init() {
        self.init(probing: linearProbing)
    }

    init(probing: @escaping Probing) {
        self.probing = probing
        hashTable.reserveCapacity(hashTableCapacity)
    }

    // MARK: Public API

    mutating
    func add(_ value: Value) {
        let isAdded = _add(value)

        if isAdded {
            rebuildHashTableIfNeeded()
        }
    }

    func values(for hashValue: Int) -> AnySequence<Value> {
        return AnySequence(
            ValueSequence(
                indices: probingSequence(for: abs(hashValue)),
                hashTable: hashTable
            ).lazy
        )
    }

    func values() -> AnySequence<Value> {
        return AnySequence(hashTable.lazy.flatMap { $0 }.filter { !$0.isDeleted }.map { $0.value })
    }

    mutating
    func remove(_ value: Value) {
        for index in probingSequence(for: abs(value.hashValue)) {
            guard var currentItem = hashTable[index] else {
                return
            }

            if value == currentItem.value {
                currentItem.isDeleted = true
                hashTable[index] = currentItem
                break
            }
        }

        rebuildHashTableIfNeeded()
    }

    func contains(_ value: Value) -> Bool {
        return values(for: abs(value.hashValue)).contains(value)
    }

    // MARK: Implementation

    private mutating
    func padTailWithNils(upToCount minCount: Int) {
        let countToPad = minCount - hashTable.count
        guard countToPad > 0 else {
            return
        }
        for _ in 0 ..< countToPad {
            hashTable.append(nil)
        }
    }

    private mutating
    func padTailWithNils(upToIndex index: Int) {
        padTailWithNils(upToCount: index + 1)
    }

    private mutating
    func _add(_ value: Value) -> Bool {
        var isAlreadyAdded = false
        for index in probingSequence(for: abs(value.hashValue)) {
            padTailWithNils(upToIndex: index)

            let currentItem = hashTable[index]

            if currentItem == nil || currentItem?.isDeleted == true {
                hashTable[index] = Item(value: value)
                break
            }

            if
                let currentItem = currentItem,
                value == currentItem.value
            {
                isAlreadyAdded = true
                hashTable[index] = Item(value: value)
                break
            }
        }

        return !isAlreadyAdded
    }

    private mutating
    func rebuild() {
        let values = hashTable.flatMap { $0 }.filter { !$0.isDeleted }.map { $0.value }
        hashTable.removeAll()
        hashTable.reserveCapacity(hashTableCapacity)
        values.forEach { _ = _add($0) }
        padTailWithNils(upToCount: hashTableCapacity)
    }

    private mutating
    func rebuildHashTableIfNeeded() {
        let items = hashTable.flatMap { $0 }

        let fillCount = items.count
        let notDeletedCount = items.filter { !$0.isDeleted }.count
        let deletedCount = fillCount - notDeletedCount

        let shouldRebuild = Float(fillCount) >= Float(hashTableCapacity) * 0.75
            && (Float(deletedCount) >= Float(notDeletedCount) * 0.4)
        let shouldInflate = Float(notDeletedCount) >= Float(hashTableCapacity) * 0.75
        let shouldDeflate = (hashTableCapacity > This.initialHashTableCapacity)
            && Float(notDeletedCount) < Float(hashTableCapacity) * 0.25

        if shouldInflate {
            hashTableCapacity *= 2
            rebuild()
        } else if shouldDeflate {
            hashTableCapacity /= 2
            rebuild()
        } else if shouldRebuild {
            rebuild()
        }
    }

    @inline(__always) private
    func probingSequence(for hashValue: Int) -> AnySequence<Int> {
        return probing(abs(hashValue), hashTableCapacity)
    }

}

// MARK: - Probing

func linearProbing(hashValue: Int, hashTableCapacity: Int) -> AnySequence<Int> {
    let capacity = hashTableCapacity
    let firstIndex = abs(hashValue) % capacity
    let indices = sequence(first: firstIndex) { ($0 + 1) % capacity }
    return AnySequence(indices)
}

func quadroProbing(hashValue: Int, hashTableCapacity capacity: Int) -> AnySequence<Int> {
    let indices = sequence(state: (result: 0, delta: 0), next: { (state: inout (result: Int, delta: Int)) -> Int in
        state = (
            result: state.result + state.delta,
            delta: state.delta + 1
        )
        return (abs(hashValue) + state.result) % capacity
    }).lazy
    return AnySequence(indices)
}
