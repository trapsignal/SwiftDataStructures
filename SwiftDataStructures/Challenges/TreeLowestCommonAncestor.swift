//
//  TreeLowestCommonAncestor.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures

extension BinarySearchTree {

    func lowestCommonAncestor(value1: Value, value2: Value) -> Value? {
        guard
            let node1 = node(for: value1),
            let node2 = node(for: value2)
        else {
            return nil
        }

        var parents1 = sequence(first: node1) { $0.parent }.lazy.makeIterator()
        var parents2 = sequence(first: node2) { $0.parent }.lazy.makeIterator()

        var parents: [Node<Value>] = []

        while true {
            let item1 = parents1.next()
            let item2 = parents2.next()

            if item1 == nil && item2 == nil {
                break
            }

            for case let item? in [item1, item2] {
                if parents.contains(where: { $0 === item }) {
                    return item.value
                } else {
                    parents.append(item)
                }
            }
        }

        return nil
    }

}
