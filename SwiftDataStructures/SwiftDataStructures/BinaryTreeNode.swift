//
//  BinaryTreeNode.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

// MARK: - BinaryTreeNode

public
class BinaryTreeNode<Value> {

    // MARK: Properties

    public
    let value: Value

    public
    var left: BinaryTreeNode?

    public
    var right: BinaryTreeNode?

    public
    var isLeaf: Bool {
        return left == nil && right == nil
    }

    // MARK: Initialization

    public
    init(_ value: Value, left: BinaryTreeNode? = nil, right: BinaryTreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }

}
