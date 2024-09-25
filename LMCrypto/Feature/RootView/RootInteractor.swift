//
//  RootInteractor.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation
import Combine

protocol RootInteractorProtocol {
    var searchText: String { get set }

    func loadAllData()
    func loadMoreList()
    func clearSearchText()
}

class RootInteractor: RootInteractorProtocol {
    // MARK: - Shared
    static let shared = RootInteractor()

    // MARK: - Property
    // data
    @Published var searchText: String = ""

    // loading state
    private(set) var isLoadingTopList = false {
        didSet {
            Task {
                await presenter?.setLoadingTopList(isLoadingTopList)
            }
        }
    }
    private(set) var isLoadingList = false {
        didSet {
            Task {
                await presenter?.setLoadingList(isLoadingTopList)
            }
        }
    }

    // response
    private var getTopCoinResponse = ApiResponseStatusModel()
    private var getCoinResponse = ApiResponseStatusModel()

    // pagination
    private var pagination = PaginationModel()

    // dependency
    weak var presenter: RootPresenter?
    private let coinRepo: CoinRepositoryProtocol

    // MARK: - Init
    init(
        presenter: RootPresenter? = nil,
        coinRepo: CoinRepositoryProtocol = CoinRepository()
    ) {
        self.presenter = presenter
        self.coinRepo = coinRepo

        bindObservable()
    }

    // MARK: - Event
    private func bindObservable() {

    }

    func loadAllData() {
        Task {
            async let topCoinList: Void = getTopCoinList()
            async let coinList: Void = getCoinList()

            _ = await [topCoinList, coinList]
        }
    }

    func loadMoreList() {
        Task {
            await getCoinList()
        }
    }

    private func getTopCoinList() async {
        guard !isLoadingTopList else { return }
        isLoadingTopList = true

        let data = await coinRepo.getCoinList(
            offset: 0,
            limit: 3,
            orderBy: .marketCap
        )

        getTopCoinResponse = data.2

        if let list = data.0, data.2.isSuccess {
            let mappedList = list.coins.map {
                CoinListItemModel(model: $0, hasInvite: false)
            }
            await presenter?.setTopCoinList(mappedList)
        }

        isLoadingTopList = false
    }

    private func getCoinList() async {
        guard !isLoadingList, pagination.hasNext else { return }
        isLoadingList = true

        let data = await coinRepo.getCoinList(
            offset: pagination.offset,
            limit: pagination.limit,
            orderBy: .marketCap
        )

        getCoinResponse = data.2

        if let list = data.0, data.2.isSuccess {
            let mappedList = list.coins.map {
                CoinListItemModel(model: $0, hasInvite: false)
            }
            pagination.loadedPage += 1
            pagination.hasNext = list.coins.count >= pagination.limit

            await presenter?.appendCoinList(mappedList)
        }

        isLoadingList = false
    }

    func clearSearchText() {
        searchText = ""
    }
}
