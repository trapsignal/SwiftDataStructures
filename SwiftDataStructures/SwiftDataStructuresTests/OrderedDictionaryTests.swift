//
//  OrderedDictionaryTests.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class OrderedDictionaryTests: XCTestCase {

    func testExample() {
        let s1 = SomeComparableKey(n: 1)
        let s2 = SomeComparableKey(n: 123)
        let s3 = SomeComparableKey(n: 6)
        let s4 = SomeComparableKey(n: 12)
        let s5 = SomeComparableKey(n: 105)
        let s6 = SomeComparableKey(n: 111)
        let s7 = SomeComparableKey(n: 24)
        let s8 = SomeComparableKey(n: 4)

        var dict3 = OrderedDictionary<Int, String>()
        dict3.set("one", for: 1)
        dict3.set("two", for: 2)
        dict3.set("three", for: 3)

        XCTAssertEqual(dict3.value(for: 1), "one")
        XCTAssertEqual(dict3.value(for: 2), "two")
        XCTAssertEqual(dict3.value(for: 3), "three")

        dict3.set("onneeee", for: 1)

        XCTAssertEqual(dict3.value(for: 1), "onneeee")

        var dict4 = OrderedDictionary<SomeComparableKey, String>()

        dict4.set("one", for: s1)
        dict4.set("one", for: s2)
        dict4.set("three", for: s3)
        dict4.set("four", for: s4)
        dict4.set("five", for: s5)
        dict4.set("six", for: s6)
        dict4.set("seven", for: s7)
        dict4.set("eight", for: s8)

        XCTAssertEqual(dict4.value(for: s1), "one")
        XCTAssertEqual(dict4.value(for: s2), "one")
        XCTAssertEqual(dict4.value(for: s3), "three")
        XCTAssertEqual(dict4.value(for: s4), "four")
        XCTAssertEqual(dict4.value(for: s5), "five")
        XCTAssertEqual(dict4.value(for: s6), "six")
        XCTAssertEqual(dict4.value(for: s7), "seven")
        XCTAssertEqual(dict4.value(for: s8), "eight")

        let countBeforeRemove2 = dict4.count

        let removedValue21 = dict4.removeValue(for: s3)

        XCTAssertEqual(removedValue21, "three")

        let countAfterRemove21 = dict4.count

        XCTAssertEqual(countBeforeRemove2, countAfterRemove21 + 1)

        let removedValue22 = dict4.removeValue(for: s3)

        XCTAssertNil(removedValue22)

        let countAfterRemove22 = dict4.count

        XCTAssertEqual(countAfterRemove21, countAfterRemove22)

        dict4.removeValue(for: s1)
        dict4.removeValue(for: s6)
        dict4.removeValue(for: s5)
        dict4.removeValue(for: s4)
        dict4.removeValue(for: s2)
        dict4.removeValue(for: s7)

        XCTAssertEqual(dict4.count, 1)
    }

}
