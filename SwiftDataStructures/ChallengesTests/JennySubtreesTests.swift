//
//  JennySubtreesTests.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import Challenges
@testable import SwiftDataStructures
import XCTest

class JennySubtreesTests: XCTestCase {

    func test1() {
        let tree = [
            (1, 2),
            (1, 3),
            (1, 4),
            (1, 5),
            (2, 6),
            (2, 7),
        ]

        XCTAssertEqual(jennySubtreesCount(tree, radius: 1), 3)
    }

    func test2() {
        let tree = [
            (1, 2),
            (1, 3),
            (1, 4),
            (1, 5),
            (2, 6),
            (2, 7),
        ]

        XCTAssertEqual(jennySubtreesCount(tree, radius: 2), 3)
    }

}
