//
//  OpenAddressingDictionary.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

typealias OpenAddressingDictionary<Key: Hashable, Value> = CustomDictionary<
    Key,
    Value,
    OpenAddressingHashTable<KeyValuePair<Key, Value>>
>
