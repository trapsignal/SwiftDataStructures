//
//  OpenAddressingHashTableTests.swift
//  SwiftDataStructuresTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class OpenAddressingHashTableTests: XCTestCase {

    func test_linearProbing() {
        var hashTable = OpenAddressingHashTable<Int>(probing: linearProbing)

        hashTable.add(1)
        hashTable.add(2)
        hashTable.add(135)
        hashTable.add(44)
        hashTable.add(1)
        hashTable.add(3)

        XCTAssertEqual(hashTable.count, 5)

        XCTAssertTrue(hashTable.contains(135))
        XCTAssertTrue(hashTable.contains(1))
        XCTAssertTrue(hashTable.contains(2))
        XCTAssertTrue(!hashTable.contains(5))

        hashTable.remove(44444)

        XCTAssertEqual(hashTable.count, 5)

        hashTable.remove(1)
        hashTable.remove(44)

        XCTAssertEqual(hashTable.count, 3)

        hashTable.add(3)
        hashTable.add(3)
        hashTable.add(3)
        hashTable.add(3)
        hashTable.add(3)
        hashTable.add(3)

        XCTAssertEqual(hashTable.count, 3)

        hashTable.add(16)
        hashTable.add(34)
        hashTable.add(5)
        hashTable.add(15)
        hashTable.add(7)
        hashTable.add(454)

        XCTAssertEqual(hashTable.count, 9)

        hashTable.remove(100500)

        XCTAssertEqual(hashTable.count, 9)

        hashTable.remove(454)
        hashTable.remove(34)
        hashTable.remove(7)
        hashTable.remove(5)
        hashTable.remove(15)
        hashTable.remove(16)
        hashTable.remove(1)
        hashTable.remove(44)
        hashTable.remove(2)

        XCTAssertEqual(hashTable.count, 2)
    }

    func test_quadroProbing() {
        var hashTable = OpenAddressingHashTable<Int>(probing: quadroProbing)

        hashTable.add(1)
        hashTable.add(2)
        hashTable.add(135)
        hashTable.add(44)
        hashTable.add(1)
        hashTable.add(3)

        XCTAssertEqual(hashTable.count, 5)

        XCTAssertTrue(hashTable.contains(135))
        XCTAssertTrue(hashTable.contains(1))
        XCTAssertTrue(hashTable.contains(2))
        XCTAssertTrue(!hashTable.contains(5))

        hashTable.remove(44444)

        XCTAssertEqual(hashTable.count, 5)

        hashTable.remove(1)
        hashTable.remove(44)

        XCTAssertEqual(hashTable.count, 3)

        hashTable.add(3)
        hashTable.add(3)
        hashTable.add(3)
        hashTable.add(3)
        hashTable.add(3)
        hashTable.add(3)

        XCTAssertEqual(hashTable.count, 3)

        hashTable.add(16)
        hashTable.add(34)
        hashTable.add(5)
        hashTable.add(15)
        hashTable.add(7)
        hashTable.add(454)

        XCTAssertEqual(hashTable.count, 9)

        hashTable.remove(100500)

        XCTAssertEqual(hashTable.count, 9)

        hashTable.remove(454)
        hashTable.remove(34)
        hashTable.remove(7)
        hashTable.remove(5)
        hashTable.remove(15)
        hashTable.remove(16)
        hashTable.remove(1)
        hashTable.remove(44)
        hashTable.remove(2)

        XCTAssertEqual(hashTable.count, 2)
    }

}
