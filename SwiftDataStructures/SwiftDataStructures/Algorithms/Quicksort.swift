//
//  Quicksort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension MutableCollection where Element: Comparable {

    private
    func getPivot(startIndex: Index, endIndex: Index) -> Element {
        return self[index(endIndex, offsetBy: -1)]
    }

    private mutating
    func partition(pivot: Element, startIndex: Index, endIndex: Index) -> Index {
        var i = startIndex
        var j = index(endIndex, offsetBy: -1)

        while i < j {
            while i < index(endIndex, offsetBy: -1) && self[i] < pivot {
                i = index(after: i)
            }

            while j > startIndex && self[j] > pivot {
                j = index(j, offsetBy: -1)
            }

            if i < j {
                swapAt(i, j)

                if self[i] == pivot && self[j] == pivot {
                    (i, j) = partitionElementsBetweenPivots(pivotIndex1: i, pivotIndex2: j)
                } else {
                    if self[i] != pivot {
                        i = index(after: i)
                    }
                    if self[j] != pivot {
                        j = index(j, offsetBy: -1)
                    }
                }
            }
        }

        return i
    }

    private mutating
    func partitionElementsBetweenPivots(pivotIndex1: Index, pivotIndex2: Index) -> (Index, Index) {
        assert(self[pivotIndex1] == self[pivotIndex2])

        let pivot = self[pivotIndex1]

        var i = pivotIndex1
        var j = pivotIndex2

        if abs(distance(from: i, to: j)) <= 1 {
            i = j
        } else {
            let next = index(after: i)
            let prev = index(j, offsetBy: -1)
            if next < endIndex, self[next] > pivot {
                i = index(after: i)
            } else if prev >= startIndex, self[prev] < pivot {
                j = index(j, offsetBy: -1)
            } else {
                if next < endIndex {
                    swapAt(i, next)
                    i = next
                }
                if prev >= startIndex {
                    swapAt(prev, j)
                    j = prev
                }
            }
        }

        return (i, j)
    }

    public mutating
    func quicksort(startIndex: Index? = nil, endIndex: Index? = nil) {
        let start = startIndex ?? self.startIndex
        let end = endIndex ?? self.endIndex

        guard start < index(end, offsetBy: -1) else {
            return
        }

        let pivot = getPivot(startIndex: start, endIndex: end)

        let pivotIndex = partition(pivot: pivot, startIndex: start, endIndex: end)

        quicksort(startIndex: start, endIndex: pivotIndex)
        quicksort(startIndex: Swift.min(index(after: pivotIndex), end), endIndex: end)
    }

    public
    func quicksorted() -> Self {
        var newCollection = self
        newCollection.quicksort()
        return newCollection
    }

}
