//
//  ChallengesTests.swift
//  ChallengesTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import Challenges
@testable import RedBlackTree
import XCTest

class ChallengesTests: XCTestCase {

    func testTopView1() {
        let tree = RedBlackTree<Int>()

        tree.add(14)
        tree.add(12)
        tree.add(3)
        tree.add(5)
        tree.add(100)
        tree.add(98)
        tree.add(1)

        let expectedTopView = [1, 3, 12, 98, 100]

        XCTAssertEqual(tree.topView(), expectedTopView)
    }

    func testTopView2() {
        let tree = RedBlackTree<Int>()

        tree.add(1)
        tree.add(2)
        tree.add(3)
        tree.add(4)
        tree.add(5)
        tree.add(6)
        tree.add(7)

        let expectedTopView = [1, 2, 4, 6, 7]

        XCTAssertEqual(tree.topView(), expectedTopView)
    }

    func testPreorderTraverse() {
        let tree = RedBlackTree<Int>()

        tree.add(14)
        tree.add(12)
        tree.add(3)
        tree.add(5)
        tree.add(100)
        tree.add(98)
        tree.add(1)

        let expectedTraversal = [12, 3, 1, 5, 98, 14, 100]

        XCTAssertEqual(tree.preorderTraversal(), expectedTraversal)
    }

    func testPostorderTraverse() {
        let tree = RedBlackTree<Int>()

        tree.add(14)
        tree.add(12)
        tree.add(3)
        tree.add(5)
        tree.add(100)
        tree.add(98)
        tree.add(1)

        let expectedTraversal = [1, 5, 3, 14, 100, 98, 12]

        XCTAssertEqual(tree.postorderTraversal(), expectedTraversal)
    }

    func testInorderTraverse() {
        let tree = RedBlackTree<Int>()

        tree.add(14)
        tree.add(12)
        tree.add(3)
        tree.add(5)
        tree.add(100)
        tree.add(98)
        tree.add(1)

        let expectedTraversal = [1, 3, 5, 12, 14, 98, 100]

        XCTAssertEqual(tree.inorderTraversal(), expectedTraversal)
    }

    func testHeight() {
        let tree = RedBlackTree<Int>()

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

        XCTAssertEqual(tree.height, 3)
    }

    func testBreadthFirstTraversal() {
        let tree = RedBlackTree<Int>()

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

        let expectedTraversal = [31, 12, 98, 3, 16, 32, 180, 1, 5, 14, 24, 100, 5000, 2, 6]

        XCTAssertEqual(tree.breadthFirstTraversal(), expectedTraversal)
    }

}
