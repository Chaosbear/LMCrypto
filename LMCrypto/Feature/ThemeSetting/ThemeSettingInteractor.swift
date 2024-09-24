//
//  ThemeSettingInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

protocol ThemeSettingInteractorProtocol {
    var presenter: ThemeSettingPresenter? { get set }

    func tapIncrease()
}

class ThemeSettingInteractor: ThemeSettingInteractorProtocol {

    // MARK: - Property
    weak var presenter: ThemeSettingPresenter?
    private var count = 0

    // MARK: - Init
    init(presenter: ThemeSettingPresenter?) {
        self.presenter = presenter
    }

    // MARK: - Event
    func tapIncrease() {
        count += 1
        presenter?.increaseCount()
    }
}
