//
//  NotificationInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

protocol NotificationInteractorProtocol {
    var presenter: NotificationPresenter? { get set }

    func tapIncrease()
}

class NotificationInteractor: NotificationInteractorProtocol {

    // MARK: - Property
    weak var presenter: NotificationPresenter?
    private var count = 0

    // MARK: - Init
    init(presenter: NotificationPresenter?) {
        self.presenter = presenter
    }

    // MARK: - Event
    func tapIncrease() {
        count += 1
        presenter?.increaseCount()
    }
}
