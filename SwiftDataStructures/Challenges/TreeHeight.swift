//
//  TreeHeight.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import RedBlackTree

extension Node {

    fileprivate var height: Int {
        let leftHeight = (left as? Node)?.height ?? 0
        let rightHeight = (right as? Node)?.height ?? 0
        return max(leftHeight, rightHeight) + 1
    }

}

extension RedBlackTree {

    var height: Int {
        return root.map { $0.height - 1 } ?? 0
    }

}
