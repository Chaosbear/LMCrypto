//
//  ArticleModel.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 10/9/2567 BE.
//

import Foundation

struct ArticleListModel {
    var page: PageModel
    var list: [ArticleModel]

    init(page: PageModel = .init(), list: [ArticleModel] = []) {
        self.page = page
        self.list = list
    }
}

extension ArticleListModel: Codable {
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case list = "list"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.page = try map.decodeIfPresent(PageModel.self, forKey: .page) ?? .init()
            self.list = try map.decodeIfPresent([ArticleModel].self, forKey: .list) ?? []
        } catch {
            self = Self()
        }
    }
}

struct ArticleModel {
    var productId: String
    var title: String
    var descripton: String
    var image: String?
    var updatedAt: String
    var authorName: String
    var authorUserId: Int
    var authorImage: String
    var engagement: EngagementModel
    var price: ProductPriceModel

    init(
        productId: String = "",
        title: String = "",
        descripton: String = "",
        image: String? = nil,
        updatedAt: String = "",
        authorName: String = "",
        authorUserId: Int = 0,
        authorImage: String = "",
        engagement: EngagementModel = .init(),
        price: ProductPriceModel = .init()
    ) {
        self.productId = productId
        self.title = title
        self.descripton = descripton
        self.image = image
        self.updatedAt = updatedAt
        self.authorName = authorName
        self.authorUserId = authorUserId
        self.authorImage = authorImage
        self.engagement = engagement
        self.price = price
    }
}

extension ArticleModel: Codable {

    enum CodingKeys: String, CodingKey {
        case productId = "productId"
        case title = "title"
        case descripton = "descripton"
        case image = "image"
        case updatedAt = "updatedAt"
        case authorName = "authorName"
        case authorUserId = "authorUserId"
        case authorImage = "authorImage"
        case engagement = "engagement"
        case price = "price"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.productId = try map.decodeIfPresent(String.self, forKey: .productId) ?? ""
            self.title = try map.decodeIfPresent(String.self, forKey: .title) ?? ""
            self.descripton = try map.decodeIfPresent(String.self, forKey: .descripton) ?? ""
            self.image = try map.decodeIfPresent(String?.self, forKey: .image) ?? nil
            self.updatedAt = try map.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
            self.authorName = try map.decodeIfPresent(String.self, forKey: .authorName) ?? ""
            self.authorUserId = try map.decodeIfPresent(Int.self, forKey: .authorUserId) ?? 0
            self.authorImage = try map.decodeIfPresent(String.self, forKey: .authorImage) ?? ""
            self.engagement = try map.decodeIfPresent(EngagementModel.self, forKey: .engagement) ?? .init()
            self.price = try map.decodeIfPresent(ProductPriceModel.self, forKey: .price) ?? .init()
        } catch {
            self = Self()
        }
    }
}
