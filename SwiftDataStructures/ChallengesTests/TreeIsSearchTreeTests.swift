//
//  TreeIsSearchTreeTests.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import Challenges
@testable import SwiftDataStructures
import XCTest

class TreeIsSearchTreeTests: XCTestCase {

    func testPositive() {
        let tree = BinaryTreeNode(
            5,
            left: BinaryTreeNode(
                3,
                left: BinaryTreeNode(1),
                right: BinaryTreeNode(4)
            ),
            right: BinaryTreeNode(
                7,
                left: BinaryTreeNode(6),
                right: BinaryTreeNode(
                    10,
                    left: BinaryTreeNode(9),
                    right: BinaryTreeNode(12)
                )
            )
        )

        XCTAssertTrue(tree.isSearchTree)
    }

    func testNegative() {
        let tree = BinaryTreeNode(
            5,
            left: BinaryTreeNode(
                3,
                left: BinaryTreeNode(1),
                right: BinaryTreeNode(2)
            ),
            right: BinaryTreeNode(
                7,
                left: BinaryTreeNode(8),
                right: BinaryTreeNode(
                    10,
                    left: BinaryTreeNode(9),
                    right: BinaryTreeNode(12)
                )
            )
        )

        XCTAssertFalse(tree.isSearchTree)
    }

}
