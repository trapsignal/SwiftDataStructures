//
//  Item.swift
//  RedBlackTree
//
//  @author trapsignal <trapsignal@yahoo.com>
//

import Foundation

// MARK: - Item

class Item<Value: Comparable> {

    // MARK: Types

    typealias TNode = Node<Value>

    enum Color {
        case black
        case red
    }

    // MARK: Properties

    weak
    var parent: TNode? {
        didSet {
            updateParent(with: parent)
        }
    }

    var color: Color

    var onBecomingRoot: ((Item) -> Void)?

    var sibling: Item? {
        return self === parent?.left
            ? parent?.right
            : parent?.left
    }

    // MARK: Initialization

    init(
        color: Color,
        parent: TNode? = nil,
        onBecomingRoot: ((Item) -> Void)? = nil
    ) {
        self.color = color
        self.parent = parent
        self.onBecomingRoot = onBecomingRoot

        updateParent(with: parent)
    }

    // MARK: Implementation

    func updateParent(with parent: Node<Value>?) {
        if parent == nil {
            onBecomingRoot?(self)
        }
    }

    func replace(with otherTreeItem: Item) {
        if let parent = parent {
            if self === parent.left {
                parent.left = otherTreeItem
            } else if self === parent.right {
                parent.right = otherTreeItem
            } else {
                assertionFailure("Tree item \(self) should be either left or right child of its parent \(parent)")
            }
        }

        otherTreeItem.parent = parent
    }

    func afterDelete1() {
        if parent != nil {
            afterDelete2()
        }
    }

    private
    func afterDelete2() {
        let sibling = self.sibling

        if sibling?.color == .red {
            parent?.color = .red
            sibling?.color = .black
            if self === parent?.left {
                parent?.rotateLeft()
            } else {
                parent?.rotateRight()
            }
        }

        afterDelete3()
    }

    private
    func afterDelete3() {
        let sibling = self.sibling

        if
            let parent = parent,
            parent.color == .black,
            sibling?.color == .black,
            let siblingNode = sibling as? Node,
            siblingNode.left.color == .black,
            siblingNode.right.color == .black
        {
            siblingNode.color = .red
            parent.afterDelete1()
        } else {
            afterDelete4()
        }
    }

    private
    func afterDelete4() {
        let sibling = self.sibling

        if
            let parent = parent,
            parent.color == .red,
            sibling?.color == .black,
            let siblingNode = sibling as? Node,
            siblingNode.left.color == .black,
            siblingNode.right.color == .black
        {
            siblingNode.color = .red
            parent.color = .black
        } else {
            afterDelete5()
        }
    }

    private
    func afterDelete5() {
        let sibling = self.sibling

        if sibling?.color == .black {
            if
                self === parent?.left,
                let siblingNode = sibling as? Node,
                siblingNode.right.color == .black,
                siblingNode.left.color == .red
            {
                siblingNode.color = .red
                siblingNode.left.color = .black
                siblingNode.rotateRight()
            } else if
                self === parent?.right,
                let siblingNode = sibling as? Node,
                siblingNode.left.color == .black,
                siblingNode.right.color == .red
            {
                siblingNode.color = .red
                siblingNode.right.color = .black
                siblingNode.rotateLeft()
            }
        }

        afterDelete6()
    }

    private
    func afterDelete6() {
        let sibling = self.sibling

        if let parentColor = parent?.color {
            sibling?.color = parentColor
        }
        parent?.color = .black

        if self === parent?.left {
            (sibling as? Node)?.right.color = .black
            parent?.rotateLeft()
        } else {
            (sibling as? Node)?.left.color = .black
            parent?.rotateRight()
        }
    }

    func printSelf(_ level: Int = 0, isLeft: Bool? = nil) {
        let tabs = String(repeating: "\t", count: level)
        let place = isLeft.map { $0 ? "left" : "right" } ?? "root"
        if let node = self as? TNode {
            print("\(tabs)\(place): value: \(node.value), color: \(color == .black ? "black" : "red")")
            node.left.printSelf(level + 1, isLeft: true)
            node.right.printSelf(level + 1, isLeft: false)
        } else {
            print("\(tabs)\(place): leaf")
        }
    }

}
