//
//  CoinDetailInteractor.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 25/9/2567 BE.
//

import Foundation

protocol CoinDetailInteractorProtocol {
    func loadData()
}

class CoinDetailInteractor: CoinDetailInteractorProtocol {
    // MARK: - Property
    // data
    private let coinId: String

    // loading state
    private(set) var isLoadingCoin = false {
        didSet {
            Task {
                await presenter?.setLoadingCoin(isLoadingCoin)
            }
        }
    }

    // dependency
    weak var presenter: CoinDetailPresenter?
    private let coinRepo: CoinRepositoryProtocol

    // MARK: - Init
    init(
        coinId: String,
        presenter: CoinDetailPresenter? = nil,
        coinRepo: CoinRepositoryProtocol = CoinRepository()
    ) {
        self.coinId = coinId
        self.presenter = presenter
        self.coinRepo = coinRepo
    }

    // MARK: - Event
    func loadData() {
        Task {
            await getCoinDetail()
        }
    }

    private func getCoinDetail() async {
        guard !isLoadingCoin else { return }
        isLoadingCoin = true

        let data = await coinRepo.getCoinDetail(id: coinId)

        if let model = data.0?.coin, data.2.isSuccess {
            let detail = CoinDetailPresenter.CoinDetailModel(model: model)
            await presenter?.setCoinDetail(detail)
        }

        await presenter?.setErrorState(ApiErrorState.defaultErrorHandler([data.2]))

        isLoadingCoin = false
    }
}
