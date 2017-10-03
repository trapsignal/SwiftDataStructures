//
//  Quicksort.swift
//  SwiftDataStructures
//
//  @author trapsignal <trapsignal@yahoo.com>
//

extension Array where Element: Comparable {

    private
    func getPivot(startIndex: Int, endIndex: Int) -> Element {
        return self[endIndex - 1]
    }

    private mutating
    func partition(pivot: Element, startIndex: Int, endIndex: Int) -> Int {
        var i = startIndex
        var j = endIndex - 1

        while i < j {
            while i < endIndex - 1 && self[i] < pivot {
                i += 1
            }

            while j > startIndex && self[j] > pivot {
                j -= 1
            }

            if i < j {
                swapAt(i, j)

                if self[i] == pivot && self[j] == pivot {
                    (i, j) = partitionElementsBetweenPivots(pivotIndex1: i, pivotIndex2: j)
                } else {
                    if self[i] != pivot {
                        i += 1
                    }
                    if self[j] != pivot {
                        j -= 1
                    }
                }
            }
        }

        return i
    }

    private mutating
    func partitionElementsBetweenPivots(pivotIndex1: Int, pivotIndex2: Int) -> (Int, Int) {
        assert(self[pivotIndex1] == self[pivotIndex2])

        let pivot = self[pivotIndex1]

        var i = pivotIndex1
        var j = pivotIndex2

        if abs(i - j) <= 1 {
            i = j
        } else {
            let next = i + 1
            let prev = j - 1
            if next < endIndex, self[next] > pivot {
                i += 1
            } else if prev >= startIndex, self[prev] < pivot {
                j -= 1
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
    func quicksort(startIndex: Int? = nil, endIndex: Int? = nil) {
        let start = startIndex ?? self.startIndex
        let end = endIndex ?? self.endIndex

        guard start < end - 1 else {
            return
        }

        let pivot = getPivot(startIndex: start, endIndex: end)

        let pivotIndex = partition(pivot: pivot, startIndex: start, endIndex: end)

        quicksort(startIndex: start, endIndex: pivotIndex)
        quicksort(startIndex: Swift.min(pivotIndex + 1, end), endIndex: end)
    }

    public
    func quicksorted() -> [Element] {
        var newArray = self
        newArray.quicksort()
        return newArray
    }

}
