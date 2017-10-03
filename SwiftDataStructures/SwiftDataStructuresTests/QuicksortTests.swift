//
//  QuicksortTests.swift
//  SwiftDataStructuresTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class QuicksortTests: XCTestCase {

    func testQuicksort_ascending() {
        var arr = [3, 2, 11, 15, 5, 1, 1, 6, 1, 2, 46, 8]
        let expectedArray = [1, 1, 1, 2, 2, 3, 5, 6, 8, 11, 15, 46]

        arr.quicksort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_ascending_alreadySorted() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]
        let expectedArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]

        arr.quicksort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_ascending_sortedDescending() {
        var arr = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        let expectedArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]

        arr.quicksort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_ascending_sameElement() {
        var arr = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
        let expectedArray = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]

        arr.quicksort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_ascending_sparse() {
        var arr = [4, 0, 0, 0, 4, 0, 1, 1560, 0, 0, 0, 0]
        let expectedArray = [0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 4, 1560]

        arr.quicksort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksorted_ascending() {
        let arr = [5, 66, 43, 2, 46, 66, 8, 11]
        let expectedArray = [2, 5, 8, 11, 43, 46, 66, 66]

        XCTAssertEqual(arr.quicksorted(by: <), expectedArray)
    }

    func testQuicksort_descending() {
        var arr = [3, 2, 11, 15, 5, 1, 1, 6, 1, 2, 46, 8]
        let expectedArray = [46, 15, 11, 8, 6, 5, 3, 2, 2, 1, 1, 1]

        arr.quicksort(by: >)
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_descending_sortedAscending() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]
        let expectedArray = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

        arr.quicksort(by: >)
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_descending_alreadySorted() {
        var arr = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        let expectedArray = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

        arr.quicksort(by: >)
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_descending_sameElement() {
        var arr = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
        let expectedArray = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]

        arr.quicksort(by: >)
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksort_descending_sparse() {
        var arr = [4, 0, 0, 0, 4, 0, 1, 1560, 0, 0, 0, 0]
        let expectedArray = [1560, 4, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0]

        arr.quicksort(by: >)
        XCTAssertEqual(arr, expectedArray)
    }

    func testQuicksorted_descending() {
        let arr = [5, 66, 43, 2, 46, 66, 8, 11]
        let expectedArray = [66, 66, 46, 43, 11, 8, 5, 2]

        XCTAssertEqual(arr.quicksorted(by: >), expectedArray)
    }

}
