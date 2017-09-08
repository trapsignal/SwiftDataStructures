//
//  List.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

// MARK: - List

struct List<Value: Equatable>: Collection {

    // MARK: Node

    class Node {

        var next: Node?
        let value: Value

        init(next: Node?, value: Value) {
            self.next = next
            self.value = value
        }

    }

    // MARK: Properties

    private
    var head: Node?

    private
    var tail: Node?

    private
    var _count = 0

    // MARK: Public API

    func traverse(_ executing: (Value) -> Void) {
        forEach { executing($0) }
    }

    mutating
    func append(_ value: Value) {
        let node = Node(next: nil, value: value)

        defer {
            _count += 1
        }

        guard tail != nil else {
            self.head = node
            self.tail = head
            return
        }

        self.tail?.next = node
        self.tail = node
    }

    mutating
    func prepend(_ value: Value) {
        let prevHead = head
        head = Node(next: prevHead, value: value)

        if tail === prevHead {
            tail = head
        }

        _count += 1
    }

    mutating
    func add(_ value: Value, after index: Int) {
        guard let prevNode = node(at: index) else {
            return
        }

        let newNode = Node(next: prevNode.next, value: value)
        prevNode.next = newNode

        if newNode.next == nil {
            tail = newNode
        }

        _count += 1
    }

    mutating
    func remove(at index: Int) {
        guard
            let prevNode = node(at: index - 1),
            let nodeToRemove = prevNode.next
        else {
            return
        }

        prevNode.next = nodeToRemove.next
        nodeToRemove.next = nil

        if prevNode.next == nil {
            tail = prevNode
        }

        _count -= 1
    }

    func index(of value: Value) -> Int? {
        return enumerated().lazy.first { $1 == value }?.offset
    }

    func value(at index: Int) -> Value? {
        return node(at: index)?.value
    }

    // MARK: Collection Conformance

    func makeIterator() -> AnyIterator<Value> {
        return AnyIterator(nodes().lazy.map { $0.value }.makeIterator())
    }

    var startIndex: Int {
        return 0
    }

    var endIndex: Int {
        return _count
    }

    subscript(index: Int) -> Value {
        guard let value = self.value(at: index) else {
            fatalError("Index is out of bounds: index \(index), count \(count)")
        }
        return value
    }

    func index(after i: Int) -> Int {
        return i + 1
    }

    // MARK: Node Helpers

    private
    func node(at index: Int) -> Node? {
        return nodes().enumerated().lazy
            .first { $0.offset == index }?.element
    }

    private
    func nodes() -> AnySequence<Node> {
        guard let head = head else {
            return AnySequence([])
        }
        return AnySequence(sequence(first: head) { $0.next })
    }

}
