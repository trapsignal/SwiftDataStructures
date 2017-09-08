//
//  ChainingHashTable.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

// MARK: - ChainingHashTable

struct ChainingHashTable<
    Value: Hashable,
    CustomHashTableBag: HashTableBag
>: HashTable where
    CustomHashTableBag.Iterator.Element == Value,
    CustomHashTableBag.IndexDistance == Int,
    CustomHashTableBag.SubSequence.SubSequence == CustomHashTableBag.SubSequence,
    CustomHashTableBag.SubSequence.Iterator.Element == Value {

    // MARK: Properties

    var count: Int {
        return hashTable.map { $0.count }.reduce(0, +)
    }

    private
    typealias This = ChainingHashTable<Value, CustomHashTableBag>

    private
    static var initialHashTableCapacity: Int {
        return 4
    }

    private
    var hashTable: [CustomHashTableBag] = []

    private
    var hashTableCapacity = initialHashTableCapacity

    // MARK: Initialization

    init() {
        hashTable.reserveCapacity(hashTableCapacity)
    }

    // MARK: Public API

    mutating
    func add(_ value: Value) {
        let isAdded = _add(value)

        if isAdded {
            resizeHashTableIfNeeded()
        }
    }

    mutating
    func remove(_ value: Value) {
        let index = bagIndex(for: value.hashValue)

        guard index < hashTable.count else {
            return
        }

        let bag = hashTable[index]
        let removedValue = bag.first { $0 == value }
        hashTable[index] = CustomHashTableBag(bag.filter { $0 != value })

        if removedValue != nil {
            resizeHashTableIfNeeded()
        }
    }

    func contains(_ value: Value) -> Bool {
        guard let bag = bag(for: value.hashValue) else {
            return false
        }

        return bag.contains(value)
    }

    func values(for hashValue: Int) -> AnySequence<Value> {
        let b = bag(for: hashValue) ?? CustomHashTableBag()
        return AnySequence<Value>(b.lazy)
    }

    func values() -> AnySequence<Value> {
        return AnySequence(hashTable.lazy.map { AnySequence($0) }.joined())
    }

    // MARK: Implementation

    @inline(__always) private
    func bagIndex(for hashValue: Int) -> Int {
        return hashValue % hashTableCapacity
    }

    private
    func bag(for hashValue: Int) -> CustomHashTableBag? {
        let index = bagIndex(for: hashValue)
        guard index < hashTable.count else {
            return nil
        }

        return hashTable[index]
    }

    @discardableResult private mutating
    func _add(_ value: Value) -> Bool {
        let index = bagIndex(for: value.hashValue)

        while hashTable.count <= index {
            hashTable.append(CustomHashTableBag())
        }

        let bag = hashTable[index]

        var newBag = bag.filter { $0 != value }
        newBag += [value]
        hashTable[index] = CustomHashTableBag(newBag)

        return newBag.count > bag.count
    }

    private mutating
    func inflate() {
        hashTableCapacity *= 2
        hashTable.reserveCapacity(hashTableCapacity)

        let allBags = hashTable.flatMap { $0 }
        hashTable.removeAll(keepingCapacity: true)

        allBags
            .flatMap { $0 }
            .forEach { _add($0) }
    }

    private mutating
    func deflate() {
        hashTableCapacity /= 2

        let allBags = hashTable.flatMap { $0 }
        hashTable.removeAll()

        hashTable.reserveCapacity(hashTableCapacity)

        allBags
            .flatMap { $0 }
            .forEach { _add($0) }
    }

    private mutating
    func resizeHashTableIfNeeded() {
        let collisionCount = hashTable.filter { $0.count > 1 }.count

        let shouldInflate = collisionCount >= hashTableCapacity / 2
        let shouldDeflate = (hashTableCapacity > This.initialHashTableCapacity)
            && (collisionCount < hashTableCapacity / 8)

        if shouldInflate {
            inflate()
        } else if shouldDeflate {
            deflate()
        }
    }

}
