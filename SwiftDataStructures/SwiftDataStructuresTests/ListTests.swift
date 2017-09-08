//
//  ListTests.swift
//  SwiftDataStructuresTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class ListTests: XCTestCase {

    func testExample() {
        var list1 = List<Int>()
        list1.append(1)
        list1.append(2)
        list1.append(3)
        list1.append(4)

        XCTAssertEqual(list1.index(of: 2), 1)
        XCTAssertNil(list1.index(of: 126))

        XCTAssertEqual(list1.value(at: 3), 4)
        XCTAssertNil(list1.value(at: 136))

        list1.add(16, after: 0)

        XCTAssertEqual(list1.index(of: 16), 1)
        XCTAssertEqual(list1.index(of: 2), 2)

        XCTAssertEqual(list1.value(at: 3), 3)
        XCTAssertNil(list1.value(at: 136))

        list1.add(444, after: 456)

        XCTAssertEqual(list1.index(of: 16), 1)
        XCTAssertEqual(list1.index(of: 2), 2)

        XCTAssertEqual(list1.value(at: 3), 3)
        XCTAssertNil(list1.value(at: 136))

        list1.remove(at: 2)

        XCTAssertEqual(list1.value(at: 2), 3)
        XCTAssertEqual(list1.index(of: 4), 3)

        list1.append(567)

        XCTAssertEqual(list1.value(at: 2), 3)
        XCTAssertEqual(list1.index(of: 4), 3)

        XCTAssertEqual(list1.value(at: 4), 567)
        XCTAssertEqual(list1.index(of: 567), 4)

        list1.prepend(42)

        XCTAssertEqual(list1.value(at: 2), 16)
        XCTAssertEqual(list1.index(of: 4), 4)

        XCTAssertEqual(list1.value(at: 4), 4)
        XCTAssertEqual(list1.index(of: 567), 5)
    }

    func testTraverse() {
        var list = List<Int>()
        list.append(1)
        list.append(2)
        list.append(3)
        list.append(4)

        var result = [Int]()
        list.traverse {
            result.append($0)
        }

        XCTAssertEqual(result, [1, 2, 3, 4])
    }

}
