//
//  HeapsortTests.swift
//  SwiftDataStructuresTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class SortingTests: XCTestCase {

    private
    func testSort(input: [Int], output: [Int], by areInIncreasingOrder: @escaping (Int, Int) -> Bool) {
        var arr1 = input
        arr1.insertsort(by: areInIncreasingOrder)
        XCTAssertEqual(arr1, output)
        XCTAssertEqual(input.insertsorted(by: areInIncreasingOrder), output)

        var arr2 = input
        arr2.quicksort(by: areInIncreasingOrder)
        XCTAssertEqual(arr2, output)
        XCTAssertEqual(input.quicksorted(by: areInIncreasingOrder), output)

        var arr3 = input
        arr3.heapsort(by: areInIncreasingOrder)
        XCTAssertEqual(arr3, output)
        XCTAssertEqual(input.heapsorted(by: areInIncreasingOrder), output)

        var arr4 = input
        arr4.bubblesort(by: areInIncreasingOrder)
        XCTAssertEqual(arr4, output)
        XCTAssertEqual(input.bubblesorted(by: areInIncreasingOrder), output)

        var arr5 = input
        arr5.selectionsort(by: areInIncreasingOrder)
        XCTAssertEqual(arr5, output)
        XCTAssertEqual(input.selectionsorted(by: areInIncreasingOrder), output)

        var arr6 = input
        arr6.mergesort(by: areInIncreasingOrder)
        XCTAssertEqual(arr6, output)
        XCTAssertEqual(input.mergesorted(by: areInIncreasingOrder), output)
    }

    func test_ascending1() {
        let input = [1, 4, 2, 3, 5, 5, 1, 3, 77, 46]
        let output = [1, 1, 2, 3, 3, 4, 5, 5, 46, 77]

        testSort(input: input, output: output, by: <)
    }

    func test_ascending2() {
        let input = [3, 2, 11, 15, 5, 1, 1, 6, 1, 2, 46, 8]
        let output = [1, 1, 1, 2, 2, 3, 5, 6, 8, 11, 15, 46]

        testSort(input: input, output: output, by: <)
    }

    func test_ascending_alreadySorted() {
        let input = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]
        let output = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]

        testSort(input: input, output: output, by: <)
    }

    func test_ascending_sortedDescending() {
        let input = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        let output = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]

        testSort(input: input, output: output, by: <)
    }

    func test_ascending_sameElement() {
        let input = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
        let output = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]

        testSort(input: input, output: output, by: <)
    }

    func test_ascending_sparse() {
        let input = [4, 0, 0, 0, 4, 0, 1, 1560, 0, 0, 0, 0]
        let output = [0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 4, 1560]

        testSort(input: input, output: output, by: <)
    }

    func test_descending() {
        let input = [3, 2, 11, 15, 5, 1, 1, 6, 1, 2, 46, 8]
        let output = [46, 15, 11, 8, 6, 5, 3, 2, 2, 1, 1, 1]

        testSort(input: input, output: output, by: >)
    }

    func test_descending_sortedAscending() {
        let input = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 13]
        let output = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

        testSort(input: input, output: output, by: >)
    }

    func test_descending_alreadySorted() {
        let input = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        let output = [13, 12, 11, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

        testSort(input: input, output: output, by: >)
    }

    func test_descending_sameElement() {
        let input = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
        let output = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]

        testSort(input: input, output: output, by: >)
    }

    func test_descending_sparse() {
        let input = [4, 0, 0, 0, 4, 0, 1, 1560, 0, 0, 0, 0]
        let output = [1560, 4, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0]

        testSort(input: input, output: output, by: >)
    }

}
