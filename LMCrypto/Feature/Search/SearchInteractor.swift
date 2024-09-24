//
//  SearchInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

protocol SearchInteractorProtocol {
    var presenter: SearchPresenter? { get set }

    func tapIncrease()
}

class SearchInteractor: SearchInteractorProtocol {

    // MARK: - Property
    weak var presenter: SearchPresenter?
    private var count = 0

    // MARK: - Init
    init(presenter: SearchPresenter?) {
        self.presenter = presenter
    }

    // MARK: - Event
    func tapIncrease() {
        count += 1
        presenter?.increaseCount()
    }
}
