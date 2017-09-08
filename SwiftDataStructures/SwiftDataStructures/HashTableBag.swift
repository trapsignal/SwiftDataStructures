//
//  HashTableBag.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

protocol HashTableBag: Collection {

    init()

    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Iterator.Element

}

extension Array: HashTableBag { }

extension List: HashTableBag {

    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Value {
        self.init()
        sequence.forEach { append($0) }
    }

}
