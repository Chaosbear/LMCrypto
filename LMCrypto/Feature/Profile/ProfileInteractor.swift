//
//  ProfileInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

protocol ProfileInteractorProtocol {
    var presenter: ProfilePresenter? { get set }

    func tapIncrease()
}

class ProfileInteractor: ProfileInteractorProtocol {

    // MARK: - Property
    weak var presenter: ProfilePresenter?
    private var count = 0

    // MARK: - Init
    init(presenter: ProfilePresenter?) {
        self.presenter = presenter
    }

    // MARK: - Event
    func tapIncrease() {
        count += 1
        presenter?.increaseCount()
    }
}
