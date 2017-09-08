//
//  CustomDictionary.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

// MARK: - CustomDictionary

struct CustomDictionary<
    Key: Hashable,
    Value,
    CustomHashTable: HashTable
>: Mapping where CustomHashTable.Value == KeyValuePair<Key, Value> {

    // MARK: Types

    private
    typealias Pair = KeyValuePair<Key, Value>

    // MARK: Properties

    var count: Int {
        return hashTable.count
    }

    private
    var hashTable = CustomHashTable()

    // MARK: Public API

    func keys() -> AnySequence<Key> {
        return AnySequence(hashTable.values().lazy.map { $0.key })
    }

    mutating
    func set(_ value: Value, for key: Key) {
        hashTable.add(Pair(key: key, value: value))
    }

    func value(for key: Key) -> Value? {
        return hashTable
            .values(for: key.hashValue)
            .first { $0.key == key }?
            .value
    }

    @discardableResult mutating
    func removeValue(for key: Key) -> Value? {
        guard let item = hashTable
            .values(for: key.hashValue)
            .first(where: { $0.key == key })
        else {
            return nil
        }

        hashTable.remove(item)
        return item.value
    }

}

// MARK: - KeyValuePair

struct KeyValuePair<Key: Hashable, Value>: Hashable {

    let key: Key
    let value: Value

    var hashValue: Int {
        return key.hashValue
    }

    static func ==(left: KeyValuePair, right: KeyValuePair) -> Bool {
        return left.key == right.key
    }

}
