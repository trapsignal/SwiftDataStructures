//
//  TreeBreadthFirstTraversal.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import RedBlackTree
@testable import SwiftDataStructures

extension Node {

    fileprivate func add(to queue: inout PriorityQueue<Value>, with priority: Int) {
        queue.push(value, priority: priority)
        [
            left as? Node,
            right as? Node
        ].forEach { $0?.add(to: &queue, with: priority + 1) }
    }

}

extension RedBlackTree {

    func breadthFirstTraverse(_ executing: (Value) -> Void) {
        var queue = PriorityQueue<Value>()
        root?.add(to: &queue, with: 0)

        while let value = queue.pop() {
            executing(value)
        }
    }

    func breadthFirstTraversal() -> [Value] {
        var result: [Value] = []
        breadthFirstTraverse { result += [$0] }
        return result
    }

}
