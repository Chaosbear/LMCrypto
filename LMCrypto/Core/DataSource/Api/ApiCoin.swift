//
//  ApiCoin.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 25/9/2567 BE.
//

import Foundation
import Alamofire

extension ApiDataSource {
    func getCoinList(offset: Int, limit: Int) -> DataRequest {
        var params = defaultParameters()
        params["offset"] = offset
        params["limit"] = limit

        return manager.apiRequest(.get, apiVersion: .v2, path: "/coins", parameters: params)
    }

    func getCoinDetail(id: String) -> DataRequest {
        return manager.apiRequest(.get, apiVersion: .v2, path: "/coins/\(id)")
    }
}
