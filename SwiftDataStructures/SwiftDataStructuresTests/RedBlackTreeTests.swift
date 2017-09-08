//
//  RedBlackTreeTests.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import RedBlackTree
import XCTest

class RedBlackTreeTests: XCTestCase {

    func test1() {
        let tree = RedBlackTree<Int>()
        tree.add(3)
        tree.add(19)
        tree.add(56)
        tree.add(14)
        tree.add(1)
        tree.add(2)

        tree.remove(10)
        tree.remove(56)
        tree.remove(14)
        tree.remove(100)

        XCTAssertTrue(tree.contains(3))
        XCTAssertTrue(tree.contains(19))
        XCTAssertTrue(tree.contains(1))
        XCTAssertTrue(tree.contains(2))
        XCTAssertFalse(tree.contains(10))
        XCTAssertFalse(tree.contains(56))
        XCTAssertFalse(tree.contains(14))
        XCTAssertFalse(tree.contains(100))
        XCTAssertFalse(tree.contains(100500))

        XCTAssertEqual(Array(tree.values()), [1, 2, 3, 19])

        tree.remove(2)

        XCTAssertEqual(tree.count, 3)

        tree.remove(19)
        tree.remove(1)
        tree.remove(3)

        XCTAssertEqual(tree.count, 0)
    }

}
