//
//  RootInteractor.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation
import Combine

protocol RootInteractorProtocol: AnyObject {
    var searchText: String { get set }
    var presenter: RootPresenter? { get set }

    func loadAllData()
    func loadMoreList()
    func resetData() async
}

class RootInteractor: RootInteractorProtocol {
    // MARK: - Shared
    static let shared = RootInteractor()

    // MARK: - Property
    // data
    @Published var searchText: String = ""
    private var totalItem = 0

    // loading state
    private(set) var isLoadingList = false {
        didSet {
            Task {
                await presenter?.setLoadingList(isLoadingList)
            }
        }
    }

    // pagination
    private var pagination = PaginationModel()

    // other
    private var disposeBag: Set<AnyCancellable> = []

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
        $searchText
            .dropFirst()
            .debounce(for: 1, scheduler: DispatchQueue.global(qos: .userInteractive))
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self, !isLoadingList else { return }
                self.pagination = .init()
                self.totalItem = 0
                Task {
                    await self.getCoinList(
                        search: text,
                        offset: self.pagination.offset
                    )
                }
            }
            .store(in: &disposeBag)
    }

    func loadAllData() {
        Task {
            await getCoinList(offset: pagination.offset)
        }
    }

    func loadMoreList() {
        Task {
            await getCoinList(search: searchText, offset: pagination.offset)
        }
    }

    private func getCoinList(search: String = "", offset: Int) async {
        guard !isLoadingList, pagination.hasNext else { return }
        isLoadingList = true

        let total = totalItem

        let data = await coinRepo.getCoinList(
            searchText: search,
            offset: offset,
            limit: pagination.limit,
            orderBy: .marketCap
        )

        if var list = data.0?.coins, data.2.isSuccess, search == searchText, pagination.offset == offset {

            var mappedList: [CoinListItemModel] = []

            if offset == 0 {
                let topList = list[0...2].map {
                    CoinListItemModel(model: $0, hasInvite: false)
                }
                mappedList = list[3...].enumerated().map { [weak self] index, coin in
                    CoinListItemModel(
                        model: coin,
                        hasInvite: self?.checkHasInvite(index: index, total: total) ?? false
                    )
                }

                await presenter?.setTopCoinList(topList)
            } else {
                mappedList = list.enumerated()
                    .map { [weak self] index, coin in
                        CoinListItemModel(
                            model: coin,
                            hasInvite: self?.checkHasInvite(index: index, total: total) ?? false
                        )
                    }
            }

            totalItem += mappedList.count
            totalItem += mappedList.count(where: { $0.hasInvite })

            isLoadingList = false

            await presenter?.appendCoinList(mappedList, isReplace: pagination.loadedPage == 0)

            pagination.loadedPage += 1
            pagination.hasNext = list.count >= pagination.limit
        } else {
            isLoadingList = false
        }

        await presenter?.setErrorState(ApiErrorState.defaultErrorHandler([data.2]))
    }

    func resetData() async {
        guard !isLoadingList else { return }
        pagination = .init()
        totalItem = 0
        await getCoinList(offset: pagination.offset)
    }

    private func checkHasInvite(index: Int, total: Int) -> Bool {
        let indexInTotal = index + total + 1

        guard indexInTotal != 5 else { return true }
        guard indexInTotal % 10 == 0 else { return false }

        return log2(Double(indexInTotal) / 5).isInteger
    }
}
