//
//  OrderedDictionary.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

import RedBlackTree

// MARK: - OrderedDictionary

public
struct OrderedDictionary<Key: Comparable, Value>: Mapping {

    // MARK: Types

    private
    typealias Pair = OrderedKeyValuePair<Key, Value>

    // MARK: Properties

    var count: Int {
        return tree.count
    }

    private
    var tree = RedBlackTree<Pair>()

    // MARK: Initialization

    public
    init() { }

    // MARK: Public API

    func keys() -> AnySequence<Key> {
        return AnySequence(tree.values().lazy.map { $0.key })
    }

    mutating
    func set(_ value: Value, for key: Key) {
        tree.add(Pair(key: key, value: value))
    }

    func value(for key: Key) -> Value? {
        return pair(for: key)?.value
    }

    @discardableResult mutating
    func removeValue(for key: Key) -> Value? {
        guard let pair = pair(for: key) else {
            return nil
        }

        tree.remove(pair)
        return pair.value
    }

    // MARK: Implementation

    private
    func pair(for key: Key) -> Pair? {
        return tree.find {
            if key == $0.key {
                return .orderedSame
            } else if key < $0.key {
                return .orderedAscending
            } else {
                return .orderedDescending
            }
        }
    }

}

// MARK: - OrderedKeyValuePair

private
struct OrderedKeyValuePair<Key: Comparable, Value>: Comparable {

    let key: Key
    let value: Value

    static func ==(left: OrderedKeyValuePair, right: OrderedKeyValuePair) -> Bool {
        return left.key == right.key
    }

    static func <(left: OrderedKeyValuePair, right: OrderedKeyValuePair) -> Bool {
        return left.key < right.key
    }

}
