//
//  HuffmanDecoding.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

class TreeNode<Value> {

    let value: Value
    var left: TreeNode?
    var right: TreeNode?

    var isLeaf: Bool {
        return left == nil && right == nil
    }

    init(_ value: Value, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }

}

typealias HuffmanPair = (character: Character, frequency: Int)

typealias HuffmanTreeNode = TreeNode<HuffmanPair>

func decode(root: HuffmanTreeNode, input: [Int]) -> String {
    var decodedCharacters: [Character] = []
    var currentNode: HuffmanTreeNode? = root

    for code in input {
        assert([0, 1].contains(code))
        currentNode = (code == 0) ? currentNode?.left : currentNode?.right
        if let node = currentNode, node.isLeaf {
            decodedCharacters.append(node.value.character)
            currentNode = root
        }
    }

    return String(decodedCharacters)
}
