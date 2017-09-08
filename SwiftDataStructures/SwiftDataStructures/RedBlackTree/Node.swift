//
//  Node.swift
//  RedBlackTree
//
//  @author trapsignal <trapsignal@yahoo.com>
//

import Foundation

// MARK: - Node

class Node<Value: Comparable>: Item<Value> {

    // MARK: Types

    enum AddResult {
        case added
        case rewritten
    }

    enum RemoveResult {
        case removed
        case notFound
    }

    typealias TTreeItem = Item<Value>

    // MARK: Properties

    var left: TTreeItem = Leaf<Value>()

    var right: TTreeItem = Leaf<Value>()

    var value: Value

    var grandparent: Node? {
        return parent?.parent
    }

    var uncle: Node? {
        guard
            let parent = parent,
            let grandparent = grandparent
        else {
            return nil
        }

        if parent === grandparent.left {
            return grandparent.right as? Node
        } else if parent === grandparent.right {
            return grandparent.left as? Node
        } else {
            let left = grandparent.left
            let right = grandparent.right
            fatalError(
                "grandparent \(grandparent) doesn't have parent \(parent) as a child. Left: \(left), right: \(right)"
            )
        }
    }

    private
    var minimumNode: Node {
        if let left = left as? Node {
            return left.minimumNode
        }

        return self
    }

    private
    var maximumNode: Node {
        if let right = right as? Node {
            return right.maximumNode
        }

        return self
    }

    // MARK: Initialization

    init(
        _ value: Value,
        color: Color,
        parent: Node? = nil,
        onBecomingRoot: ((TTreeItem) -> Void)? = nil
    ) {
        self.value = value

        super.init(color: color, parent: parent, onBecomingRoot: onBecomingRoot)

        self.left.parent = self
        self.right.parent = self

        self.left.onBecomingRoot = onBecomingRoot
        self.right.onBecomingRoot = onBecomingRoot

        updateParent(with: parent)
    }

    func traverse(executing: (Value) -> Void) {
        values().forEach(executing)
    }

    func values() -> AnySequence<Value> {
        let mine = AnySequence(CollectionOfOne(value))
        let left = (self.left as? Node)?.values()
        let right = (self.right as? Node)?.values()
        return AnySequence([left, mine, right].flatMap { $0 }.joined().lazy)
    }

    func add(_ value: Value) -> AddResult {
        if value < self.value {
            if let left = left as? Node {
                return left.add(value)
            } else {
                let newNode = Node(value, color: .red, parent: self, onBecomingRoot: onBecomingRoot)
                left = newNode
                newNode.afterAddition1()
                return .added
            }
        } else if value > self.value {
            if let right = right as? Node {
                return right.add(value)
            } else {
                let newNode = Node(value, color: .red, parent: self, onBecomingRoot: onBecomingRoot)
                right = newNode
                newNode.afterAddition1()
                return .added
            }
        } else {
            self.value = value
            return .rewritten
        }
    }

    func remove(_ value: Value) -> RemoveResult {
        if value < self.value {
            return (left as? Node)?.remove(value) ?? .notFound
        } else if self.value < value {
            return (right as? Node)?.remove(value) ?? .notFound
        } else {
            remove()
            return .removed
        }
    }

    func contains(_ value: Value) -> Bool {
        if value == self.value {
            return true
        }

        return value < self.value
            ? ((left as? Node)?.contains(value) ?? false)
            : ((right as? Node)?.contains(value) ?? false)
    }

    func find(where compare: (Value) -> ComparisonResult) -> Value? {
        switch compare(value) {
        case .orderedSame:
            return value
        case .orderedAscending:
            return (left as? Node)?.find(where: compare)
        case .orderedDescending:
            return (right as? Node)?.find(where: compare)
        }
    }

    func rotateLeft() {
        guard let pivot = right as? Node else {
            return assertionFailure()
        }

        pivot.parent = parent

        if parent != nil {
            if self === parent?.left {
                parent?.left = pivot
            } else {
                parent?.right = pivot
            }
        }

        right = pivot.left

        pivot.left.parent = self

        parent = pivot
        pivot.left = self
    }

    func rotateRight() {
        guard let pivot = left as? Node else {
            return assertionFailure()
        }

        pivot.parent = parent

        if parent != nil {
            if self === parent?.left {
                parent?.left = pivot
            } else {
                parent?.right = pivot
            }
        }

        left = pivot.right

        pivot.right.parent = self

        parent = pivot
        pivot.right = self
    }

    private
    func afterAddition1() {
        if parent == nil {
            color = .black
        } else {
            afterAddition2()
        }
    }

    private
    func afterAddition2() {
        if parent?.color == .black {
            return
        } else {
            afterAddition3()
        }
    }

    private
    func afterAddition3() {
        if let uncle = uncle, uncle.color == .red {
            parent?.color = .black
            uncle.color = .black
            let grandparent = self.grandparent
            grandparent?.color = .red
            grandparent?.afterAddition1()
        } else {
            afterAddition4()
        }
    }

    private
    func afterAddition4() {
        let grandparent = self.grandparent
        var nextNode: Node? = self

        if self === parent?.right && parent === grandparent?.left {
            parent?.rotateLeft()
            nextNode = left as? Node
        } else if self === parent?.left && parent === grandparent?.right {
            parent?.rotateRight()
            nextNode = right as? Node
        }

        nextNode?.afterAddition5()
    }

    private
    func afterAddition5() {
        let grandparent = self.grandparent

        parent?.color = .black
        grandparent?.color = .red

        if self === parent?.left && parent === grandparent?.left {
            grandparent?.rotateRight()
        } else {
            assert(self === parent?.right)
            assert(parent === grandparent?.right)
            grandparent?.rotateLeft()
        }
    }

    private
    func remove() {
        if let left = left as? Node, right is Node {
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
            left is Leaf || right is Leaf,
            "Failed to meet a precondition of this method to have either left or right child nil."
        )

        let child = (left is Node) ? left : right

        replace(with: child)

        if color == .black {
            if child.color == .red {
                child.color = .black
            } else {
                child.afterDelete1()
            }
        }
    }

    // MARK: Self Checking

    func checkInvariants() {
        // root is always black
        if parent == nil {
            assert(color == .black)
        }

        // both children of red node are black
        checkColors()

        // lengths of all possible paths to leaves are equal
        assert(Node.countOfBlackLevels(left) == Node.countOfBlackLevels(right))

        // left and right nodes should have self as parent
        checkParent()
    }

    static private
    func countOfBlackLevels(_ TreeItem: TTreeItem) -> Int {
        guard let node = TreeItem as? Node else {
            return 1
        }

        let increment = (node.color == .black) ? 1 : 0
        return max(
            Node.countOfBlackLevels(node.left),
            Node.countOfBlackLevels(node.right)
        ) + increment
    }

    private
    func checkColors() {
        // both children of red node are black
        if color == .red {
            assert(left.color == .black)
            assert(right.color == .black)
        }

        (left as? Node)?.checkColors()
        (right as? Node)?.checkColors()
    }

    private
    func checkParent() {
        assert(left.parent === self)
        assert(right.parent === self)

        (left as? Node)?.checkParent()
        (right as? Node)?.checkParent()
    }

}
