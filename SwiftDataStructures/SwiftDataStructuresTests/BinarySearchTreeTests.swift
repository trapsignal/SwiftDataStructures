//
//  BinarySearchTreeTests.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class BinarySearchTreeTests: XCTestCase {

    func testAdd() {
        let bst = BinarySearchTree<Int>()

        bst.add(1)
        bst.add(3)
        bst.add(10)
        bst.add(5)
        bst.add(2)
        bst.add(4)
        bst.add(8)

        XCTAssertEqual(bst.root?.value, 1)
        XCTAssertNil(bst.root?.left)
        XCTAssertEqual(bst.root?.right?.value, 3)
        XCTAssertEqual(bst.root?.right?.left?.value, 2)
        XCTAssertEqual(bst.root?.right?.right?.left?.value, 5)
        XCTAssertEqual(bst.root?.right?.right?.left?.left?.value, 4)
        XCTAssertEqual(bst.root?.right?.right?.left?.right?.value, 8)
    }

    func testContains() {
        let bst = BinarySearchTree<Int>()

        bst.add(1)
        bst.add(3)
        bst.add(10)
        bst.add(5)
        bst.add(2)
        bst.add(4)
        bst.add(8)

        XCTAssertTrue(bst.contains(2))
        XCTAssertTrue(bst.contains(10))
        XCTAssertTrue(bst.contains(5))
        XCTAssertTrue(bst.contains(3))
        XCTAssertTrue(bst.contains(4))
        XCTAssertTrue(bst.contains(8))
        XCTAssertTrue(bst.contains(1))
        XCTAssertFalse(bst.contains(11))
        XCTAssertFalse(bst.contains(100500))
        XCTAssertFalse(bst.contains(-8))
    }

    func testRemove() {
        let bst = BinarySearchTree<Int>()

        bst.add(1)
        bst.add(3)
        bst.add(10)
        bst.add(5)
        bst.add(2)
        bst.add(4)
        bst.add(8)

        bst.remove(4)

        XCTAssertTrue(bst.contains(2))
        XCTAssertTrue(bst.contains(10))
        XCTAssertTrue(bst.contains(5))
        XCTAssertTrue(bst.contains(3))
        XCTAssertTrue(bst.contains(8))
        XCTAssertTrue(bst.contains(1))
        XCTAssertFalse(bst.contains(4))

        bst.remove(10)

        XCTAssertTrue(bst.contains(2))
        XCTAssertTrue(bst.contains(5))
        XCTAssertTrue(bst.contains(3))
        XCTAssertTrue(bst.contains(8))
        XCTAssertTrue(bst.contains(1))
        XCTAssertFalse(bst.contains(4))
        XCTAssertFalse(bst.contains(10))

        bst.remove(8)
        bst.remove(2)
        bst.remove(5)
        bst.remove(1)
        bst.remove(3)

        XCTAssertFalse(bst.contains(2))
        XCTAssertFalse(bst.contains(5))
        XCTAssertFalse(bst.contains(3))
        XCTAssertFalse(bst.contains(8))
        XCTAssertFalse(bst.contains(1))
        XCTAssertFalse(bst.contains(4))
        XCTAssertFalse(bst.contains(10))
    }

}
