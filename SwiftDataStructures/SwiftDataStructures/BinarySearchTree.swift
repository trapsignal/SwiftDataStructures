//
//  BinarySearchTree.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

// MARK: - BinarySearchTree

class BinarySearchTree<Value: Comparable> {

    // MARK: Properties

    var root: Node<Value>?

    // MARK: Public API

    func add(_ value: Value) {
        if let root = root {
            root.add(value)
        } else {
            root = Node(value, parent: nil, onBecomingRoot: { [weak self] in
                self?.root = $0
            })
        }
    }

    func remove(_ value: Value) {
        root?.remove(value)
    }

    func contains(_ value: Value) -> Bool {
        return root?.contains(value) ?? false
    }

}

// MARK: - Node

class Node<Value: Comparable> {

    // MARK: Properties

    var value: Value
    var left: Node?
    var right: Node?
    var onBecomingRoot: (Node?) -> Void

    weak
    var parent: Node? {
        didSet {
            updateParent(with: parent)
        }
    }

    private
    var minimumNode: Node {
        if let left = left {
            return left.minimumNode
        }

        return self
    }

    private
    var maximumNode: Node {
        if let right = right {
            return right.maximumNode
        }

        return self
    }

    // MARK: Initialization

    fileprivate
    init(_ value: Value, parent: Node?, onBecomingRoot: @escaping (Node?) -> Void) {
        self.value = value
        self.parent = parent
        self.onBecomingRoot = onBecomingRoot

        updateParent(with: parent)
    }

    // MARK: File Private API

    fileprivate
    func add(_ value: Value) {
        if value < self.value {
            if let left = self.left {
                left.add(value)
            } else {
                left = Node(value, parent: self, onBecomingRoot: onBecomingRoot)
            }
        } else if value > self.value {
            if let right = self.right {
                right.add(value)
            } else {
                right = Node(value, parent: self, onBecomingRoot: onBecomingRoot)
            }
        } else {
            self.value = value
        }
    }

    fileprivate
    func contains(_ value: Value) -> Bool {
        if value == self.value {
            return true
        } else if value < self.value {
            return left?.contains(value) ?? false
        } else {
            return right?.contains(value) ?? false
        }
    }

    fileprivate
    func remove(_ value: Value) {
        if value < self.value {
            left?.remove(value)
        } else if value > self.value {
            right?.remove(value)
        } else if value == self.value {
            remove()
        }
    }

    // MARK: Implementation

    private
    func remove() {
        if let left = left, right != nil {
            let replacingNode = left.maximumNode
            value = replacingNode.value
            replacingNode.removeGivenLessThanTwoChild()
        } else {
            removeGivenLessThanTwoChild()
        }
    }

    private
    func removeGivenLessThanTwoChild() {
        assert(
            left == nil || right == nil,
            "Failed to meet a precondition of this method to have either left or right child nil."
        )

        let child = left ?? right
        replace(with: child)

        if child == nil, parent == nil {
            onBecomingRoot(nil)
        }
    }

    private
    func replace(with otherNode: Node?) {
        if let parent = parent {
            if self === parent.left {
                parent.left = otherNode
            } else if self === parent.right {
                parent.right = otherNode
            } else {
                assertionFailure("Node \(self) should be either left or right child of its parent \(parent)")
            }
        }

        otherNode?.parent = parent
    }

    private
    func updateParent(with parent: Node?) {
        if parent == nil {
            onBecomingRoot(self)
        }
    }

}
