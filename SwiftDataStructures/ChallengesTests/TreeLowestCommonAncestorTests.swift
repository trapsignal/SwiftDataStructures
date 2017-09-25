//
//  TreeLowestCommonAncestorTests.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import Challenges
@testable import SwiftDataStructures
import XCTest

class TreeLowestCommonAncestorTests: XCTestCase {

    func test() {
        let tree = BinarySearchTree<Int>()

        tree.add(14)
        tree.add(12)
        tree.add(3)
        tree.add(5)
        tree.add(100)
        tree.add(98)
        tree.add(1)
        tree.add(32)
        tree.add(31)
        tree.add(5000)
        tree.add(16)
        tree.add(2)
        tree.add(24)
        tree.add(6)
        tree.add(180)

        XCTAssertEqual(tree.lowestCommonAncestor(value1: 180, value2: 31), 100)
        XCTAssertEqual(tree.lowestCommonAncestor(value1: 6, value2: 1), 3)
        XCTAssertEqual(tree.lowestCommonAncestor(value1: 2, value2: 16), 14)
    }

}
