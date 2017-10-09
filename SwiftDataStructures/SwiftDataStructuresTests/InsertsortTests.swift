//
//  InsertsortTests.swift
//  SwiftDataStructuresTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class InsertsortTests: XCTestCase {

    func testInsertsort_ascending1() {
        var arr = [1, 4, 2, 3, 5, 5, 1, 3, 77, 46]
        let expectedArray = [1, 1, 2, 3, 3, 4, 5, 5, 46, 77]

        arr.insertsort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsort_ascending2() {
        var arr = [3, 2, 11, 15, 5, 1, 1, 6, 1, 2, 46, 8]
        let expectedArray = [1, 1, 1, 2, 2, 3, 5, 6, 8, 11, 15, 46]

        arr.insertsort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsort_ascending_alreadySorted() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]
        let expectedArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]

        arr.insertsort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsort_ascending_sortedDescending() {
        var arr = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        let expectedArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]

        arr.insertsort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsort_ascending_sameElement() {
        var arr = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
        let expectedArray = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]

        arr.insertsort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsort_ascending_sparse() {
        var arr = [4, 0, 0, 0, 4, 0, 1, 1560, 0, 0, 0, 0]
        let expectedArray = [0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 4, 1560]

        arr.insertsort(by: <)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsorted_ascending() {
        let arr = [5, 66, 43, 2, 46, 66, 8, 11]
        let expectedArray = [2, 5, 8, 11, 43, 46, 66, 66]

        XCTAssertEqual(arr.insertsorted(by: <), expectedArray)
    }

    func testInsertsort_descending() {
        var arr = [3, 2, 11, 15, 5, 1, 1, 6, 1, 2, 46, 8]
        let expectedArray = [46, 15, 11, 8, 6, 5, 3, 2, 2, 1, 1, 1]

        arr.insertsort(by: >)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsort_descending_sortedAscending() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]
        let expectedArray = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

        arr.insertsort(by: >)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsort_descending_alreadySorted() {
        var arr = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        let expectedArray = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

        arr.insertsort(by: >)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsort_descending_sameElement() {
        var arr = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
        let expectedArray = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]

        arr.insertsort(by: >)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsort_descending_sparse() {
        var arr = [4, 0, 0, 0, 4, 0, 1, 1560, 0, 0, 0, 0]
        let expectedArray = [1560, 4, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0]

        arr.insertsort(by: >)
        XCTAssertEqual(arr, expectedArray)
    }

    func testInsertsorted_descending() {
        let arr = [5, 66, 43, 2, 46, 66, 8, 11]
        let expectedArray = [66, 66, 46, 43, 11, 8, 5, 2]

        XCTAssertEqual(arr.insertsorted(by: >), expectedArray)
    }

}
