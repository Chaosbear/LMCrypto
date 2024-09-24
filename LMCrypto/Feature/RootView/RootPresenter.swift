//
//  RootPresenter.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

class RootPresenter: ObservableObject {
    // MARK: - Shared
    static let shared = RootPresenter()

    // MARK: - Property
    @Published private(set) var selectedTab: RootViewTab = .home

    // MARK: - Event
    func selectTab(tab: RootViewTab) {
        if tab != selectedTab {
            selectedTab = tab
        }
    }
}
