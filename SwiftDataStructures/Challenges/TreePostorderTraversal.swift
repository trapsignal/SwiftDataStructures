//
//  PostorderTraversal.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import RedBlackTree

extension Node {

    func postorderTraverse(_ executing: (Value) -> Void) {
        if let leftNode = left as? Node {
            leftNode.postorderTraverse(executing)
        }

        if let rightNode = right as? Node {
            rightNode.postorderTraverse(executing)
        }

        executing(value)
    }

}

extension RedBlackTree {

    func postorderTraverse(_ executing: (Value) -> Void) {
        root?.postorderTraverse(executing)
    }

    func postorderTraversal() -> [Value] {
        var result: [Value] = []
        postorderTraverse { result += [$0] }
        return result
    }

}
