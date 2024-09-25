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

    func getCoinList(offset: Int, limit: Int, orderBy: CoinOrderByType) -> DataRequest {
        var params = defaultParameters()
        params["offset"] = offset
        params["limit"] = limit
        params["orderBy"] = orderBy.rawValue

        return manager.apiRequest(.get, apiVersion: .v2, path: "/coins", parameters: params)
    }

    func getCoinDetail(id: String) -> DataRequest {
        return manager.apiRequest(.get, apiVersion: .v2, path: "/coin/\(id)")
    }
}
