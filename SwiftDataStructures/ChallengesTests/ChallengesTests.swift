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

}
