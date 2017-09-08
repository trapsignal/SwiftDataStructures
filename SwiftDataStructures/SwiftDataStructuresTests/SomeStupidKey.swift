//
//  SomeStupidKey.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

struct SomeStupidKey: Hashable {

    var n = 0

    var hashValue: Int {
        return n.hashValue
    }

    static func ==(left: SomeStupidKey, right: SomeStupidKey) -> Bool {
        return left.n == right.n
    }

}

struct SomeComparableKey: Comparable {

    var n = 0

    var hashValue: Int {
        return n.hashValue
    }

    static func ==(left: SomeComparableKey, right: SomeComparableKey) -> Bool {
        return left.n == right.n
    }

    static func <(left: SomeComparableKey, right: SomeComparableKey) -> Bool {
        return left.n < right.n
    }

}
