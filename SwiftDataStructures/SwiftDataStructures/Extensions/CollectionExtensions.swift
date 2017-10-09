//
//  CollectionExtensions.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension Collection {

    func index(before i: Index) -> Index {
        return index(i, offsetBy: -1)
    }

}
