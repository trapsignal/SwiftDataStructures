//
//  ReverseLinkedList.swift
//  Challenges
//
//  @author trapsignal <trapsignal@yahoo.com>
//

@testable import SwiftDataStructures

public
extension Listable {

    mutating
    func reverseList() {
        var currentNode: Node? = self.head
        var prevNode: Node? = nil
        while var curNode = currentNode {
            let nextNode = curNode.next
            curNode.next = prevNode
            prevNode = curNode
            currentNode = nextNode
        }
        self.head = prevNode
    }

}

public
extension Listable where Self: Copyable {

    func reversedList() -> Self {
        var newList = copy()
        newList.reverseList()
        return newList
    }

}

public
protocol Copyable {

    func copy() -> Self

}

extension List: Copyable {

    public
    func copy() -> List {
        let arr = Array(self)
        var newList = List()
        arr.forEach { newList.append($0) }
        return newList
    }

}

extension EnumList: Copyable {

    public
    func copy() -> EnumList {
        let arr = Array(self)
        var newList = EnumList()
        arr.forEach { newList.append($0) }
        return newList
    }

}
