//
//  ArticleInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

protocol ArticleInteractorProtocol {
    var presenter: ArticlePresenter? { get set }

    func tapIncrease()
}

class ArticleInteractor: ArticleInteractorProtocol {

    // MARK: - Property
    weak var presenter: ArticlePresenter?
    private var count = 0

    // MARK: - Init
    init(presenter: ArticlePresenter?) {
        self.presenter = presenter
    }

    // MARK: - Event
    func tapIncrease() {
        count += 1
        presenter?.increaseCount()
    }
}
