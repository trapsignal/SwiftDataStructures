//
//  HuffmanDecoding.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

import SwiftDataStructures

typealias HuffmanPair = (character: Character, frequency: Int)

typealias HuffmanTreeNode = BinaryTreeNode<HuffmanPair>

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
