//
//  MutableCollectionExtensions.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension MutableCollection {

    mutating
    func rewrite(with items: [Element], range: Range<Index>? = nil) {
        let range = range ?? startIndex ..< endIndex
        guard !range.isEmpty, !items.isEmpty else {
            return
        }
        var index = range.lowerBound
        for i in 0 ..< items.count {
            self[index] = items[i]
            index = self.index(after: index)
            if index == range.upperBound {
                return
            }
        }
    }

}
