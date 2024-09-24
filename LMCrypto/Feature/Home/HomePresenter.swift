//
//  HomePresenter.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 30/8/2567 BE.
//

import Foundation

@MainActor
class HomePresenter: ObservableObject {
    // MARK: - Property
    // data
    @Published private(set) var sectionList: [ScreenSectionItemModel] = []

    // loading state
    @Published private(set) var isShowSkeleton = true

    // error state
    @Published private(set) var errorState: ApiErrorState = .noError

    // MARK: - Init
    init(sectionList: [ScreenSectionItemModel] = []) {
        self.sectionList = sectionList
    }

    // MARK: - Event
    func setData(_ list: [ScreenSectionItemModel], _ errState: ApiErrorState) async {
        sectionList = list
        errorState = errState
        if isShowSkeleton {
            isShowSkeleton = false
        }
    }
}
