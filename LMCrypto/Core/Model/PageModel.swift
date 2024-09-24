//
//  PageModel.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 10/9/2567 BE.
//

import Foundation

struct PageModel {
    var current: Int
    var hasPrevious: Bool
    var hasNext: Bool
    var itemPerPage: Int
    var totalItem: Int

    init(
        current: Int = 0,
        hasPrevious: Bool = false,
        hasNext: Bool = false,
        itemPerPage: Int = 0,
        totalItem: Int = 0
    ) {
        self.current = current
        self.hasPrevious = hasPrevious
        self.hasNext = hasNext
        self.itemPerPage = itemPerPage
        self.totalItem = totalItem
    }
}

extension PageModel: Codable {

    enum CodingKeys: String, CodingKey {
        case current = "current"
        case hasPrevious = "hasPrevious"
        case hasNext = "hasNext"
        case itemPerPage = "itemPerPage"
        case totalItem = "totalItem"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.current = try map.decodeIfPresent(Int.self, forKey: .current) ?? 0
            self.hasPrevious = try map.decodeIfPresent(Bool.self, forKey: .hasPrevious) ?? false
            self.hasNext = try map.decodeIfPresent(Bool.self, forKey: .hasNext) ?? false
            self.itemPerPage = try map.decodeIfPresent(Int.self, forKey: .itemPerPage) ?? 0
            self.totalItem = try map.decodeIfPresent(Int.self, forKey: .totalItem) ?? 0
        } catch {
            self = Self()
        }
    }
}
