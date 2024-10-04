//
//  RootPresenter.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation

@MainActor
class RootPresenter: ObservableObject {
    // MARK: - Shared
    static let shared = RootPresenter()

    // MARK: - Property
    // coin data
    @Published private(set) var topCoinList: [CoinListItemModel] = []
    @Published private(set) var coinList: [CoinListItemModel] = [] {
        didSet {
            lastCoinId = coinList.last?.id
        }
    }
    private(set) var lastCoinId: String?

    // loading state
    @Published private(set) var isShowSkeleton = true
    @Published private(set) var isLoadingList = false

    // error state
    @Published private(set) var isEmptyList = false
    @Published private(set) var errorState: ApiErrorState = .noError

    // other
    @Published private(set) var scrollToTop = false

    // MARK: - Event
    func setTopCoinList(_ list: [CoinListItemModel]) async {
        topCoinList = list
    }

    func appendCoinList(_ list: [CoinListItemModel], isReplace: Bool) async {
        if isReplace {
            if !coinList.isEmpty {
                scrollToTop = true
            }
            coinList = list
        } else {
            coinList.append(contentsOf: list)
        }
    }

    func setLoadingList(_ isLoading: Bool) {
        isLoadingList = isLoading
        if isShowSkeleton && !isLoadingList {
            isShowSkeleton = false
        }
    }

    func setErrorState(_ error: ApiErrorState) {
        errorState = error
        isEmptyList = errorState == .noError && coinList.isEmpty
    }
}
