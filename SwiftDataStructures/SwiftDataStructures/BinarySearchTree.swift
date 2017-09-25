//
//  BinarySearchTree.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

class Node<Value: Comparable> {

    var value: Value
    var left: Node?
    var right: Node?
    var onBecomingRoot: (Node?) -> Void

    weak var parent: Node? {
        didSet {
            updateParent(with: parent)
        }
    }

    init(_ value: Value, parent: Node?, onBecomingRoot: @escaping (Node?) -> Void) {
        self.value = value
        self.parent = parent
        self.onBecomingRoot = onBecomingRoot

        updateParent(with: parent)
    }

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

    func contains(_ value: Value) -> Bool {
        if value == self.value {
            return true
        } else if value < self.value {
            return left?.contains(value) ?? false
        } else {
            return right?.contains(value) ?? false
        }
    }

    fileprivate static func remove(_ value: Value, from node: Node) {
        if value < node.value, let left = node.left {
            remove(value, from: left)
        } else if value > node.value, let right = node.right {
            remove(value, from: right)
        } else if value == node.value {
            node.remove()
        }
    }

    private func remove() {
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

    func replace(with otherNode: Node?) {
        if let parent = parent {
            if self === parent.left {
                parent.left = otherNode
            } else if self === parent.right {
                parent.right = otherNode
            } else {
                assertionFailure("Tree item \(self) should be either left or right child of its parent \(parent)")
            }
        }

        otherNode?.parent = parent
    }

    private func updateParent(with parent: Node?) {
        if parent == nil {
            onBecomingRoot(self)
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

}

class BinarySearchTree<Value: Comparable> {

    var root: Node<Value>?

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
        if let root = root {
            Node.remove(value, from: root)
        }
    }

    func contains(_ value: Value) -> Bool {
        return root?.contains(value) ?? false
    }

}
