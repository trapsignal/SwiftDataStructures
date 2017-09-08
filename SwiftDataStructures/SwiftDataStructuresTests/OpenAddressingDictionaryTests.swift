//
//  OpenAddressingDictionaryTests.swift
//  SwiftDataStructuresTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures
import XCTest

class OpenAddressingDictionaryTests: XCTestCase {

    func testExample() {
        let s1 = SomeStupidKey(n: 1)
        let s2 = SomeStupidKey(n: 123)
        let s3 = SomeStupidKey(n: 6)
        let s4 = SomeStupidKey(n: 12)
        let s5 = SomeStupidKey(n: 105)
        let s6 = SomeStupidKey(n: 111)
        let s7 = SomeStupidKey(n: 24)
        let s8 = SomeStupidKey(n: 4)

        var dict3 = OpenAddressingDictionary<Int, String>()
        _ = dict3.set("one", for: 1)
        _ = dict3.set("two", for: 2)
        _ = dict3.set("three", for: 3)

        XCTAssertEqual(dict3.value(for: 1), "one")
        XCTAssertEqual(dict3.value(for: 2), "two")
        XCTAssertEqual(dict3.value(for: 3), "three")

        _ = dict3.set("onneeee", for: 1)

        XCTAssertEqual(dict3.value(for: 1), "onneeee")

        var dict4 = OpenAddressingDictionary<SomeStupidKey, String>()

        _ = dict4.set("one", for: s1)
        _ = dict4.set("two", for: s2)
        _ = dict4.set("three", for: s3)
        _ = dict4.set("four", for: s4)
        _ = dict4.set("five", for: s5)
        _ = dict4.set("six", for: s6)
        _ = dict4.set("seven", for: s7)
        _ = dict4.set("eight", for: s8)

        XCTAssertEqual(dict4.value(for: s1), "one")
        XCTAssertEqual(dict4.value(for: s2), "two")
        XCTAssertEqual(dict4.value(for: s3), "three")
        XCTAssertEqual(dict4.value(for: s4), "four")
        XCTAssertEqual(dict4.value(for: s5), "five")
        XCTAssertEqual(dict4.value(for: s6), "six")
        XCTAssertEqual(dict4.value(for: s7), "seven")
        XCTAssertEqual(dict4.value(for: s8), "eight")

        let countBeforeRemove2 = dict4.count

        XCTAssertEqual(dict4.removeValue(for: s3), "three")

        let countAfterRemove21 = dict4.count

        XCTAssertEqual(countBeforeRemove2, countAfterRemove21 + 1)

        XCTAssertEqual(dict4.removeValue(for: s3), nil)

        let countAfterRemove22 = dict4.count

        XCTAssertEqual(countAfterRemove21, countAfterRemove22)

        XCTAssertEqual(dict4.removeValue(for: s1), "one")
        XCTAssertEqual(dict4.removeValue(for: s6), "six")
        XCTAssertEqual(dict4.removeValue(for: s5), "five")
        XCTAssertEqual(dict4.removeValue(for: s4), "four")
        XCTAssertEqual(dict4.removeValue(for: s2), "two")
        XCTAssertEqual(dict4.removeValue(for: s7), "seven")

        XCTAssertNil(dict4.value(for: s1))
        XCTAssertNil(dict4.value(for: s6))
        XCTAssertNil(dict4.value(for: s5))
        XCTAssertNil(dict4.value(for: s4))
        XCTAssertNil(dict4.value(for: s2))
        XCTAssertNil(dict4.value(for: s7))
        XCTAssertEqual(dict4.value(for: s8), "eight")
    }

}
