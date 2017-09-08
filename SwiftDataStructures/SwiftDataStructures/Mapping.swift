//
//  Mapping.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

protocol Mapping {

    associatedtype Key
    associatedtype Value

    var count: Int { get }

    mutating
    func set(_ value: Value, for key: Key)

    mutating
    func removeValue(for key: Key) -> Value?

    func value(for key: Key) -> Value?

    func keys() -> AnySequence<Key>

}

extension Mapping {

    func pairs() -> AnySequence<(key: Key, value: Value)> {
        return AnySequence(keys().lazy.flatMap { key in
            self.value(for: key).map { value in (key: key, value: value) }
        })
    }

}
