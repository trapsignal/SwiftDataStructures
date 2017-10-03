//
//  ArrayPairTests.swift
//  ChallengesTests
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import Challenges
import XCTest

class ArrayPairTests: XCTestCase {

    func test() {
        let arr = [1, 1, 2, 4, 2]

        XCTAssertEqual(arrayPairs(arr), 8)
    }

}
