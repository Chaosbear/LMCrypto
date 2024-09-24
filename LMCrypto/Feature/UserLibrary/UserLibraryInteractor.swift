//
//  UserLibraryInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

protocol UserLibraryInteractorProtocol {
    var presenter: UserLibraryPresenter? { get set }

    func tapIncrease()
}

class UserLibraryInteractor: UserLibraryInteractorProtocol {

    // MARK: - Property
    weak var presenter: UserLibraryPresenter?
    private var count = 0

    // MARK: - Init
    init(presenter: UserLibraryPresenter?) {
        self.presenter = presenter
    }

    // MARK: - Event
    func tapIncrease() {
        count += 1
        presenter?.increaseCount()
    }
}
