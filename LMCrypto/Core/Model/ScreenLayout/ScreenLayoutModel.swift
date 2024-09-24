//
//  ScreenLayoutModel.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 8/9/2567 BE.
//

import Foundation

struct ScreenLayoutModel {
    var totalSection: Int
    var list: [ScreenSectionModel]

    init(totalSection: Int = 0, list: [ScreenSectionModel] = []) {
        self.totalSection = totalSection
        self.list = list
    }
}

extension ScreenLayoutModel: Codable {

    enum CodingKeys: String, CodingKey {
        case totalSection = "totalSection"
        case list = "list"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.totalSection = try map.decodeIfPresent(Int.self, forKey: .totalSection) ?? 0
            self.list = try map.decodeIfPresent([ScreenSectionModel].self, forKey: .list) ?? []
        } catch {
            self = Self()
        }
    }
}
