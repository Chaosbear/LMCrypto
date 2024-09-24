//
//  AuthorProfileInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

protocol AuthorProfileInteractorProtocol {
    var presenter: AuthorProfilePresenter? { get set }

    func tapIncrease()
}

class AuthorProfileInteractor: AuthorProfileInteractorProtocol {

    // MARK: - Property
    weak var presenter: AuthorProfilePresenter?
    private var count = 0

    // MARK: - Init
    init(presenter: AuthorProfilePresenter?) {
        self.presenter = presenter
    }

    // MARK: - Event
    func tapIncrease() {
        count += 1
        presenter?.increaseCount()
    }
}
