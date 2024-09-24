//
//  ScreenSectionModel.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 8/9/2567 BE.
//

import Foundation

enum ScreenSectionType: String {
    case userShortCut
    case carouselBanner
    case horizontalArticle
    case horizontalCourse
}

struct ScreenSectionModel {
    var type: String
    var title: String?
    var url: String
    var parameter: [String: String]?

    init(
        type: String = "",
        title: String? = nil,
        url: String = "",
        parameter: [String: String]? = nil
    ) {
        self.type = type
        self.title = title
        self.url = url
        self.parameter = parameter
    }

    func getType() -> ScreenSectionType? {
        ScreenSectionType.init(rawValue: type)
    }
}

extension ScreenSectionModel: Codable {

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case title = "title"
        case url = "url"
        case parameter = "parameter"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.type = try map.decodeIfPresent(String.self, forKey: .type) ?? ""
            self.title = try map.decodeIfPresent(String?.self, forKey: .title) ?? nil
            self.url = try map.decodeIfPresent(String.self, forKey: .url) ?? ""
            self.parameter = try map.decodeIfPresent([String: String]?.self, forKey: .parameter) ?? nil
        } catch {
            self = Self()
        }
    }
}
