//
//  ArrayExtension.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation

extension Array {
    func filterDuplicates(includeElement: @escaping (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element] {
        var results = [Element]()

        forEach { element in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.isEmpty {
                results.append(element)
            }
        }

        return results
    }

    init(repeating: [Element], count: Int) {
        self.init([[Element]](repeating: repeating, count: count).flatMap {$0})
    }

    func repeated(count: Int) -> [Element] {
        return [Element](repeating: self, count: count)
    }

    subscript (safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
