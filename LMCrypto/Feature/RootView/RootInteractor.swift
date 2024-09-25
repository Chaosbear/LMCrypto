//
//  RootInteractor.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation

protocol RootInteractorProtocol {
    func selectTab(tab: Int)
}

class RootInteractor: RootInteractorProtocol {
    // MARK: - Shared
    static let shared = RootInteractor()

    // MARK: - Property
    weak var presenter: RootPresenter?

    // MARK: - Event
    func selectTab(tab: Int) {
        if tab != presenter?.selectedTab {
            presenter?.selectTab(tab: tab)
        }
    }
}
