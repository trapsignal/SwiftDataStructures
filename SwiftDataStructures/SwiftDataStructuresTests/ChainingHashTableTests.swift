//
//  ChainingHashTableTests.swift
//  SwiftDataStructuresTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class ChainingHashTableTests: XCTestCase {

    func test_array_based_1() {
        var cs2 = ChainingHashTable<Int, [Int]>()

        cs2.add(1)
        cs2.add(2)
        cs2.add(135)
        cs2.add(44)
        cs2.add(1)
        cs2.add(3)

        XCTAssertEqual(cs2.count, 5)

        XCTAssertTrue(cs2.contains(135))
        XCTAssertTrue(cs2.contains(1))
        XCTAssertTrue(cs2.contains(2))
        XCTAssertFalse(cs2.contains(5))

        cs2.remove(44444)

        XCTAssertEqual(cs2.count, 5)

        cs2.remove(1)
        cs2.remove(44)

        XCTAssertEqual(cs2.count, 3)
    }

    func test_array_based_2() {
        var hashTable = ChainingHashTable<Int, [Int]>()

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

    func test_list_based_1() {
        var cs2 = ChainingHashTable<Int, List<Int>>()

        cs2.add(1)
        cs2.add(2)
        cs2.add(135)
        cs2.add(44)
        cs2.add(1)
        cs2.add(3)

        XCTAssertEqual(cs2.count, 5)

        XCTAssertTrue(cs2.contains(135))
        XCTAssertTrue(cs2.contains(1))
        XCTAssertTrue(cs2.contains(2))
        XCTAssertFalse(cs2.contains(5))

        cs2.remove(44444)

        XCTAssertEqual(cs2.count, 5)

        cs2.remove(1)
        cs2.remove(44)

        XCTAssertEqual(cs2.count, 3)
    }

    func test_list_based_2() {
        var hashTable = ChainingHashTable<Int, List<Int>>()

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
