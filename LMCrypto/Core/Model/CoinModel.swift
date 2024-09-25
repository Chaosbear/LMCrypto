//
//  CoinModel.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation

struct CoinListModel {
    var coins: [CoinModel]

    init(coins: [CoinModel] = []) {
        self.coins = coins
    }
}

extension CoinListModel: Codable {
    enum CodingKeys: String, CodingKey {
        case coins = "coins"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.coins = try map.decodeIfPresent([CoinModel].self, forKey: .coins) ?? []
        } catch {
            self = Self()
        }
    }
}

struct CoinDetailModel {
    var coin: CoinModel

    init(coin: CoinModel = .init()) {
        self.coin = coin
    }
}

extension CoinDetailModel: Codable {
    enum CodingKeys: String, CodingKey {
        case coin = "coin"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.coin = try map.decodeIfPresent(CoinModel.self, forKey: .coin) ?? .init()
        } catch {
            self = Self()
        }
    }
}

struct CoinModel {
    var uuid: String
    var symbol: String
    var name: String
    var description: String?
    var color: String
    var iconUrl: String
    var marketCap: String
    var price: String
    var change: String
    var rank: Int
    var websiteUrl: String?

    init(
        uuid: String = "",
        symbol: String = "",
        name: String = "",
        description: String? = nil,
        color: String = "",
        iconUrl: String = "",
        marketCap: String = "",
        price: String = "",
        change: String = "",
        rank: Int = 0,
        websiteUrl: String? = nil
    ) {
        self.uuid = uuid
        self.symbol = symbol
        self.name = name
        self.description = description
        self.color = color
        self.iconUrl = iconUrl
        self.marketCap = marketCap
        self.price = price
        self.change = change
        self.rank = rank
        self.websiteUrl = websiteUrl
    }
}

extension CoinModel: Codable {

    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case symbol = "symbol"
        case name = "name"
        case description = "description"
        case color = "color"
        case iconUrl = "iconUrl"
        case marketCap = "marketCap"
        case price = "price"
        case change = "change"
        case rank = "rank"
        case websiteUrl = "websiteUrl"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.uuid = try map.decodeIfPresent(String.self, forKey: .uuid) ?? ""
            self.symbol = try map.decodeIfPresent(String.self, forKey: .symbol) ?? ""
            self.name = try map.decodeIfPresent(String.self, forKey: .name) ?? ""
            self.description = try map.decodeIfPresent(String?.self, forKey: .description) ?? nil
            self.color = try map.decodeIfPresent(String.self, forKey: .color) ?? ""
            self.iconUrl = try map.decodeIfPresent(String.self, forKey: .iconUrl) ?? ""
            self.marketCap = try map.decodeIfPresent(String.self, forKey: .marketCap) ?? ""
            self.price = try map.decodeIfPresent(String.self, forKey: .price) ?? ""
            self.change = try map.decodeIfPresent(String.self, forKey: .change) ?? ""
            self.rank = try map.decodeIfPresent(Int.self, forKey: .rank) ?? 0
            self.websiteUrl = try map.decodeIfPresent(String.self, forKey: .websiteUrl) ?? nil
        } catch {
            self = Self()
        }
    }
}
