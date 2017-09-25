//
//  InorderTraversal.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import RedBlackTree

extension Node {

    func inorderTraverse(_ executing: (Value) -> Void) {
        if let leftNode = left as? Node {
            leftNode.inorderTraverse(executing)
        }

        executing(value)

        if let rightNode = right as? Node {
            rightNode.inorderTraverse(executing)
        }
    }

}

extension RedBlackTree {

    func inorderTraverse(_ executing: (Value) -> Void) {
        root?.inorderTraverse(executing)
    }

    func inorderTraversal() -> [Value] {
        var result: [Value] = []
        inorderTraverse { result += [$0] }
        return result
    }

}
