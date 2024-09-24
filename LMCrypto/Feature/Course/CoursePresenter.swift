//
//  CoursePresenter.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import Foundation

class CoursePresenter: ObservableObject {
    @Published private(set) var index: Int = 0
    @Published private(set) var count: Int = 0

    func increaseCount() {
        count += 1
    }
}
