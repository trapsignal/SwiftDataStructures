//
//  HeapsortTests.swift
//  SwiftDataStructuresTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class HeapsortTests: XCTestCase {

    func test_1() {
        var arr = [1, 4, 2, 3, 5, 5, 1, 3, 77, 46]
        let expectedArray = [1, 1, 2, 3, 3, 4, 5, 5, 46, 77]

        arr.heapsort()
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_ascending() {
        var arr = [3, 2, 11, 15, 5, 1, 1, 6, 1, 2, 46, 8]
        let expectedArray = [1, 1, 1, 2, 2, 3, 5, 6, 8, 11, 15, 46]

        arr.heapsort()
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_ascending_alreadySorted() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]
        let expectedArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]

        arr.heapsort()
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_ascending_sortedDescending() {
        var arr = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        let expectedArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]

        arr.heapsort()
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_ascending_sameElement() {
        var arr = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
        let expectedArray = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]

        arr.heapsort()
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_ascending_sparse() {
        var arr = [4, 0, 0, 0, 4, 0, 1, 1560, 0, 0, 0, 0]
        let expectedArray = [0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 4, 1560]

        arr.heapsort()
        XCTAssertEqual(arr, expectedArray)
    }

}
