//
//  ApiCoin.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 25/9/2567 BE.
//

import Foundation
import Alamofire

extension ApiDataSource {
    enum CoinOrderByType: String {
        case marketCap
        case price
        case volume = "24hVolume"
        case change
        case listedAt
    }

    func getCoinList(
        searchText: String,
        offset: Int,
        limit: Int,
        orderBy: CoinOrderByType
    ) async -> DataRequest {
        var params = defaultParameters()
        if !searchText.isEmpty {
            params["search"] = searchText
        }
        params["offset"] = offset
        params["limit"] = limit
        params["orderBy"] = orderBy.rawValue

        return manager.apiRequest(.get, apiVersion: .v2, path: "/coins", parameters: params)
    }

    func getCoinDetail(id: String) async -> DataRequest {
        return manager.apiRequest(.get, apiVersion: .v2, path: "/coin/\(id)")
    }
}
