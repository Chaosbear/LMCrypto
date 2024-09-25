//
//  RootPresenter.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation

class RootPresenter: ObservableObject {
    // MARK: - Shared
    static let shared = RootPresenter()

    // MARK: - Property
    @Published private(set) var selectedTab: Int = 0

    // MARK: - Event
    func selectTab(tab: Int) {
        if tab != selectedTab {
            selectedTab = tab
        }
    }
}
