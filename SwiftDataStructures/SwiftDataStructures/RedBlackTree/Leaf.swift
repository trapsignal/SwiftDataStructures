//
//  Leaf.swift
//  RedBlackTree
//
//  @author trapsignal <trapsignal@yahoo.com>
//

import Foundation

// MARK: - Leaf

class Leaf<Value: Comparable>: Item<Value> {

    override
    var color: Item<Value>.Color {
        didSet {
            assert(color == .black, "Leaf color should be black always")
        }
    }

    init(
        parent: Node<Value>? = nil,
        onBecomingRoot: ((Item<Value>) -> Void)? = nil
    ) {
        super.init(color: .black, parent: parent, onBecomingRoot: onBecomingRoot)
    }

}
