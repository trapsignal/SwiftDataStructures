//
//  ReverseLinkedListTests.swift
//  ChallengesTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import Challenges
@testable import SwiftDataStructures
import XCTest

class ReverseLinkedListTests: XCTestCase {

    private
    func testReverse<
        L: Listable & Copyable & Sequence,
        C: MutableCollection & BidirectionalCollection
    >(
        list: L,
        input: C,
        output: C
    ) where C.Element == Int, L.Element == Int {
        var reversedList = list.copy()
        reversedList.reverseList()

        XCTAssertEqual([Int](list), [Int](input))
        XCTAssertEqual([Int](reversedList), [Int](output))
        XCTAssertEqual([Int](list.reversedList()), [Int](output))
    }

    func testList() {
        let inputArray = [
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9
        ]
        let outputArray = [
            9, 8, 7, 6, 5, 4, 3, 2, 1, 0
        ]

        let list = List<Int>(inputArray)
        testReverse(list: list, input: inputArray, output: outputArray)
    }

    func testEnumList() {
        let inputArray = [
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9
        ]
        let outputArray = [
            9, 8, 7, 6, 5, 4, 3, 2, 1, 0
        ]

        let list = EnumList<Int>(inputArray)
        testReverse(list: list, input: inputArray, output: outputArray)
    }

}
