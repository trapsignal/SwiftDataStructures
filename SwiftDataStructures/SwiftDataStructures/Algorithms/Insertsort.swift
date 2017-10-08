//
//  Insertsort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension Array where Element: Comparable {

    public mutating
    func insertsort() {
        for oldIndex in startIndex ..< endIndex {
            let element = self[oldIndex]
            if let newIndex = (startIndex ..< oldIndex).first(where: { element < self[$0] }) {
                let movedElement = remove(at: oldIndex)
                insert(movedElement, at: newIndex)
            }
        }
    }

    public
    func insertsorted() -> [Element] {
        var newArray = self
        newArray.insertsort()
        return newArray
    }

}
