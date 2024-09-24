//
//  CourseInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

protocol CourseInteractorProtocol {
    var presenter: CoursePresenter? { get set }

    func tapIncrease()
}

class CourseInteractor: CourseInteractorProtocol {

    // MARK: - Property
    weak var presenter: CoursePresenter?
    private var count = 0

    // MARK: - Init
    init(presenter: CoursePresenter?) {
        self.presenter = presenter
    }

    // MARK: - Event
    func tapIncrease() {
        count += 1
        presenter?.increaseCount()
    }
}
