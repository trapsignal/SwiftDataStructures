//
//  QuicksortTests.swift
//  SwiftDataStructuresTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class QuicksortTests: XCTestCase {

    func test_1() {
        var arr = [3, 2, 11, 15, 5, 1, 1, 6, 1, 2, 46, 8]
        let expectedArray = [1, 1, 1, 2, 2, 3, 5, 6, 8, 11, 15, 46]

        arr.quicksort()
        XCTAssertEqual(arr, expectedArray)
    }

    func test_2() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]
        let expectedArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]

        arr.quicksort()
        XCTAssertEqual(arr, expectedArray)
    }

    func test_3() {
        var arr = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        let expectedArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]

        arr.quicksort()
        XCTAssertEqual(arr, expectedArray)
    }

    func test_4() {
        var arr = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
        let expectedArray = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]

        arr.quicksort()
        XCTAssertEqual(arr, expectedArray)
    }

    func test_5() {
        var arr = [4, 0, 0, 0, 4, 0, 1, 1560, 0, 0, 0, 0]
        let expectedArray = [0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 4, 1560]

        arr.quicksort()
        XCTAssertEqual(arr, expectedArray)
    }

    func test_6() {
        let arr = [5, 66, 43, 2, 46, 66, 8, 11]
        let expectedArray = [2, 5, 8, 11, 43, 46, 66, 66]

        XCTAssertEqual(arr.quicksorted(), expectedArray)
    }

}
