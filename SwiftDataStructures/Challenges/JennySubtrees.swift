//
//  JennySubtrees.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

typealias Tree = [(Int, Int)]

func nodeNumbers(of tree: Tree) -> Set<Int> {
    return tree.reduce(Set<Int>()) { set, pair in
        var newSet = set
        newSet.insert(pair.0)
        newSet.insert(pair.1)
        return newSet
    }
}

fileprivate
struct Node {
    let number: Int
    let connections: Set<Int>

    var edges: Tree {
        return connections.map { (number, $0) }
    }
}

fileprivate
func nodesByNumbers(of tree: Tree) -> [Int: Node] {
    var nodesByNumbers: [Int: Node] = [:]
    for edge in tree {
        if let node = nodesByNumbers[edge.0] {
            var newConnections = node.connections
            newConnections.insert(edge.1)
            nodesByNumbers[edge.0] = Node(number: edge.0, connections: newConnections)
        } else {
            nodesByNumbers[edge.0] = Node(number: edge.0, connections: Set([edge.1]))
        }
        if let node = nodesByNumbers[edge.1] {
            var newConnections = node.connections
            newConnections.insert(edge.0)
            nodesByNumbers[edge.1] = Node(number: edge.1, connections: newConnections)
        } else {
            nodesByNumbers[edge.1] = Node(number: edge.1, connections: Set([edge.0]))
        }
    }
    return nodesByNumbers
}

fileprivate
func subtree(for node: Node, nodesByNumbers: [Int: Node], excluding excludedConnection: Int, radius: Int) -> Tree {
    guard radius > 0 else {
        return []
    }
    return node.connections
        .filter { $0 != excludedConnection }
        .map { nextNodeNumber -> Tree in
            let nextSubtree = nodesByNumbers[nextNodeNumber].map {
                subtree(for: $0, nodesByNumbers: nodesByNumbers, excluding: node.number, radius: radius - 1)
            } ?? []
            return [(node.number, nextNodeNumber)] + nextSubtree
        }.flatMap { $0 }
}

fileprivate
func subtrees(nodesByNumbers: [Int: Node], radius: Int) -> [Tree] {
    let allSubtrees = nodesByNumbers.values.map {
        subtree(for: $0, nodesByNumbers: nodesByNumbers, excluding: $0.number, radius: radius)
    }

    return Array(allSubtrees)
}

fileprivate
class TreeRepresentation: Hashable {

    private
    let nodes: [Node]

    init(nodes: [Node]) {
        self.nodes = nodes
    }

    var hashValue: Int {
        return nodes.count.hashValue ^ nodes.reduce(0) { $0 ^ innerConnections(of: $1).count.hashValue }
    }

    func innerConnections(of node: Node) -> [Int] {
        let nodeNumbersSet = Set(nodes.map { $0.number })
        return node.connections.filter { nodeNumbersSet.contains($0) }
    }

    static func ==(left: TreeRepresentation, right: TreeRepresentation) -> Bool {
        let leftConnections = Array(left.nodes.map { left.innerConnections(of: $0).count }).sorted()
        let rightConnections = Array(right.nodes.map { right.innerConnections(of: $0).count }).sorted()

        return left.nodes.count == right.nodes.count
        && leftConnections == rightConnections
    }

}

func jennySubtreesCount(_ tree: Tree, radius: Int) -> Int {
    let nodes = nodesByNumbers(of: tree)
    let trees = subtrees(nodesByNumbers: nodes, radius: radius)

    let representations = Set(
        trees.map { tree in
            TreeRepresentation(nodes: nodeNumbers(of: tree).flatMap { nodes[$0] })
        }
    )

    return representations.count
}
