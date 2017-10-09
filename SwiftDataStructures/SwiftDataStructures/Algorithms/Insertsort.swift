//
//  Insertsort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension MutableCollection where Element: Comparable {

    public mutating
    func insertsort(by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool) rethrows {
        var oldIndex = startIndex
        while oldIndex != endIndex {
            let element = self[oldIndex]

            var newIndex = startIndex
            while newIndex != oldIndex {
                if try areInIncreasingOrder(element, self[newIndex]) {
                    moveElement(from: oldIndex, to: newIndex)
                    break
                }
                newIndex = index(after: newIndex)
            }

            oldIndex = index(after: oldIndex)
        }
    }

    public
    func insertsorted(by areInIncreasingOrder: @escaping (Element, Element) throws -> Bool) rethrows -> Self {
        var newCollection = self
        try newCollection.insertsort(by: areInIncreasingOrder)
        return newCollection
    }

}

private
extension MutableCollection where Element: Comparable {

    mutating
    func moveElement(from oldIndex: Index, to newIndex: Index) {
        guard oldIndex != newIndex else {
            return
        }

        let element = self[oldIndex]

        let isMovingBack = newIndex < oldIndex
        let forwardOffset: IndexDistance = isMovingBack ? -1 : 1
        let backwardOffset: IndexDistance = -forwardOffset

        var index = self.index(oldIndex, offsetBy: forwardOffset)
        while index != self.index(newIndex, offsetBy: forwardOffset) {
            self[self.index(index, offsetBy: backwardOffset)] = self[index]
            index = self.index(index, offsetBy: forwardOffset)
        }

        self[newIndex] = element
    }

}
