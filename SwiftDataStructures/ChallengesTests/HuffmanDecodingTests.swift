//
//  HuffmanDecodingTests.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import Challenges
import XCTest

class HuffmanDecodingTests: XCTestCase {

    func test() {
        let tree = HuffmanTreeNode(
            (character: "\0", frequency: 5),
            left: HuffmanTreeNode(
                (character: "\0", frequency: 2),
                left: HuffmanTreeNode((character: "B", frequency: 1)),
                right: HuffmanTreeNode((character: "C", frequency: 1))
            ),
            right: HuffmanTreeNode((character: "A", 3))
        )

        XCTAssertEqual(decode(root: tree, input: [1, 0, 0, 1, 0, 1, 1]), "ABACA")
    }

}
