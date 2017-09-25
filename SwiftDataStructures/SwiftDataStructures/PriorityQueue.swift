//
//  PriorityQueue.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

public
struct PriorityQueue<Value> {

    private
    var items: [(value: Value, priority: Int)] = []

    public
    init() { }

    public mutating
    func push(_ value: Value, priority: Int) {
        let index = items.index { priority < $0.priority } ?? items.endIndex
        items.insert((value: value, priority: priority), at: max(0, index))
    }

    public mutating
    func pop() -> Value? {
        return !items.isEmpty ? items.removeFirst().value : nil
    }

    public
    func peek() -> Value? {
        return !items.isEmpty ? items[0].value : nil
    }

}
