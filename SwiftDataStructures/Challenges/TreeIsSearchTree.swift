//
//  TreeIsSearchTree.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

import SwiftDataStructures

extension BinaryTreeNode where Value: Comparable {

    var isSearchTree: Bool {
        if let left = left, value < left.value {
            return false
        }

        if let right = right, value > right.value {
            return false
        }

        return (left?.isSearchTree ?? true) && (right?.isSearchTree ?? true)
    }

}
