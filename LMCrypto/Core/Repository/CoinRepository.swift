//
//  CoinRepository.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation

protocol CoinRepositoryProtocol {
    func getCoinList(
        offset: Int,
        limit: Int,
        orderBy: ApiDataSource.CoinOrderByType
    ) async -> (CoinListModel?, ApiBaseModel<CoinListModel>?, ApiResponseStatusModel)

    func getCoinDetail(id: String) async -> (CoinDetailModel?, ApiBaseModel<CoinDetailModel>?, ApiResponseStatusModel)
}

struct CoinRepository: CoinRepositoryProtocol {
    let dataSource: ApiDataSource

    init(_ dataSource: ApiDataSource = ApiDataSource.shared) {
        self.dataSource = dataSource
    }

    func getCoinList(
        offset: Int,
        limit: Int,
        orderBy: ApiDataSource.CoinOrderByType
    ) async -> (CoinListModel?, ApiBaseModel<CoinListModel>?, ApiResponseStatusModel) {
        let response = await dataSource.getCoinList(
            offset: offset,
            limit: limit,
            orderBy: orderBy
        )
        .serializingDecodableHandler(
            of: ApiBaseModel<CoinListModel>.self,
            err: ApiBaseModel<CoinListModel>.self
        )

        return (response.0?.data, response.1, response.2)
    }

    func getCoinDetail(id: String) async -> (CoinDetailModel?, ApiBaseModel<CoinDetailModel>?, ApiResponseStatusModel) {
        let response = await dataSource.getCoinDetail(id: id)
            .serializingDecodableHandler(
                of: ApiBaseModel<CoinDetailModel>.self,
                err: ApiBaseModel<CoinDetailModel>.self
            )

        return (response.0?.data, response.1, response.2)
    }
}
