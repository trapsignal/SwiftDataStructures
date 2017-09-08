//
//  RedBlackTree.swift
//  RedBlackTree
//
//  @author trapsignal <trapsignal@yahoo.com>
//

import Foundation

// MARK: - RedBlackTree

public
class RedBlackTree<Value: Comparable> {

    // MARK: Properties

    public
    var count = 0

    private(set)
    var root: Node<Value>?

    // MARK: Initialization

    public
    init() {
        root = nil
    }

    public
    init(value: Value) {
        root = Node(value, color: .black)
        count += 1
    }

    // MARK: Public API

    public
    func add(_ value: Value) {
        if
            let root = root,
            root.add(value) == .added
        {
            count += 1
        } else {
            root = Node(
                value,
                color: .black,
                onBecomingRoot: { [weak self] in self?.root = $0 as? Node }
            )
            count += 1
        }

        root?.checkInvariants()
    }

    public
    func remove(_ value: Value) {
        guard let root = root else {
            return
        }

        if root.remove(value) == .removed {
            count -= 1
        }

        self.root?.checkInvariants()
    }

    public
    func contains(_ value: Value) -> Bool {
        return root?.contains(value) ?? false
    }

    public
    func find(where compare: (Value) -> ComparisonResult) -> Value? {
        return root?.find(where: compare)
    }

    public
    func traverse(executing: (Value) -> Void) {
        root?.traverse(executing: executing)
    }

    public
    func values() -> AnySequence<Value> {
        return root?.values() ?? AnySequence([])
    }

}
