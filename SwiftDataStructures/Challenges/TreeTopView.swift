//
//  TreeTopView.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import RedBlackTree

extension RedBlackTree {

    func topView() -> [Value] {
        guard let root = root else {
            return []
        }

        var indicesToValues: [Int: (Int, Value)] = [:]
        explore(node: root, atLevel: 0, atCoordinate: 0, indicesToValues: &indicesToValues)
        return indicesToValues.keys.sorted().flatMap { indicesToValues[$0]?.1 }
    }

    private
    func explore(
        node: Node<Value>,
        atLevel level: Int,
        atCoordinate coordinate: Int,
        indicesToValues: inout [Int: (Int, Value)]
    ) {
        if let previous = indicesToValues[coordinate] {
            if previous.0 > level {
                indicesToValues[coordinate] = (level, node.value)
            }
        } else {
            indicesToValues[coordinate] = (level, node.value)
        }

        if let left = node.left as? Node<Value> {
            explore(
                node: left,
                atLevel: level + 1,
                atCoordinate: coordinate - 1,
                indicesToValues: &indicesToValues
            )
        }

        if let right = node.right as? Node<Value> {
            explore(
                node: right,
                atLevel: level + 1,
                atCoordinate: coordinate + 1,
                indicesToValues: &indicesToValues
            )
        }
    }

}
