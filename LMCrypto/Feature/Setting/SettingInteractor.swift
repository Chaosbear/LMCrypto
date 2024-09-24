//
//  SettingInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

protocol SettingInteractorProtocol {
    var presenter: SettingPresenter? { get set }

    func tapIncrease()
}

class SettingInteractor: SettingInteractorProtocol {

    // MARK: - Property
    weak var presenter: SettingPresenter?
    private var count = 0

    // MARK: - Init
    init(presenter: SettingPresenter?) {
        self.presenter = presenter
    }

    // MARK: - Event
    func tapIncrease() {
        count += 1
        presenter?.increaseCount()
    }
}
