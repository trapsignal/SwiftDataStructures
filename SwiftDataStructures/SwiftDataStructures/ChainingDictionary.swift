//
//  ChainingDictionary.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

typealias ChainingDictionary<Key: Hashable, Value> = CustomDictionary<
    Key,
    Value,
    ChainingHashTable<
        KeyValuePair<Key, Value>,
        [KeyValuePair<Key, Value>]
    >
>
