//
//  CoinDetailPresenter.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 25/9/2567 BE.
//

import SwiftUI

@MainActor
class CoinDetailPresenter: ObservableObject {
    // MARK: - Type
    struct CoinDetailModel {
        let icon: URL?
        let symbol: String
        let name: String
        let nameColor: Color
        let price: String
        let marketCap: String
        let description: String
        let coinWebsite: URL?

        init(model: CoinModel) {
            self.icon = model.iconUrl.encodedUrl()?.deletingPathExtension().appendingPathExtension("png")
            self.symbol = model.symbol
            self.name = model.name
            self.nameColor = Color(model.color)
            self.price = "$ " + Utils.numberFormatter(withNumber: model.price, decimal: 2)
            let capital = Utils.numberFormatterWithSIPrefix(
                withNumber: model.marketCap,
                minPrefix: .mega,
                maxPrefix: .tera,
                decimalPlaces: 2,
                prefixUnit: .magnitude
            )
            self.marketCap = "$ " + capital
            self.description = model.description ?? ""
            self.coinWebsite = model.websiteUrl?.encodedUrl()
        }
    }

    // MARK: - Property
    // coin data
    @Published private(set) var coinDetail: CoinDetailModel?

    // loading state
    @Published private(set) var isShowSkeleton = true
    @Published private(set) var isLoadingCoin = false

    // error state
    @Published private(set) var errorState: ApiErrorState = .noError

    // MARK: - Event
    func setCoinDetail(_ detail: CoinDetailModel) async {
        coinDetail = detail
    }

    func setLoadingCoin(_ isLoading: Bool) {
        isLoadingCoin = isLoading
        if isShowSkeleton && !isLoadingCoin {
            isShowSkeleton = false
        }
    }

    func setErrorState(_ error: ApiErrorState) {
        errorState = error
    }
}
