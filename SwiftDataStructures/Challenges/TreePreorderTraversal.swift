//
//  PreorderTraversal.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import RedBlackTree

extension Node {

    func preorderTraverse(_ executing: (Value) -> Void) {
        executing(value)

        if let leftNode = left as? Node {
            leftNode.preorderTraverse(executing)
        }

        if let rightNode = right as? Node {
            rightNode.preorderTraverse(executing)
        }
    }

}

extension RedBlackTree {

    func preorderTraverse(_ executing: (Value) -> Void) {
        root?.preorderTraverse(executing)
    }

    func preorderTraversal() -> [Value] {
        var result: [Value] = []
        preorderTraverse { result += [$0] }
        return result
    }

}
