//
//  RootInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

protocol RootInteractorProtocol {
    func selectTab(tab: RootViewTab)
}

class RootInteractor: RootInteractorProtocol {
    // MARK: - Shared
    static let shared = RootInteractor()

    // MARK: - Property
    weak var presenter: RootPresenter?

    // MARK: - Event
    func selectTab(tab: RootViewTab) {
        if tab != presenter?.selectedTab {
            presenter?.selectTab(tab: tab)
        }
    }
}
