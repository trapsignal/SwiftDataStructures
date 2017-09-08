//
//  HashTable.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

protocol HashTable {

    associatedtype Value: Hashable

    var count: Int { get }

    init()

    mutating
    func add(_ value: Value)

    mutating
    func remove(_ value: Value)

    func contains(_ value: Value) -> Bool

    func values(for hashValue: Int) -> AnySequence<Value>

    func values() -> AnySequence<Value>

}
