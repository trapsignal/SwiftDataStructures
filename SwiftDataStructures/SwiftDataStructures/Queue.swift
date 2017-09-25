//
//  Queue.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

struct Queue<Value> {

    private var items: [Value] = []

    mutating func push(_ value: Value) {
        items.append(value)
    }

    mutating func pop() -> Value? {
        return !items.isEmpty ? items.removeFirst() : nil
    }

    func peek() -> Value? {
        return !items.isEmpty ? items[0] : nil
    }

}
