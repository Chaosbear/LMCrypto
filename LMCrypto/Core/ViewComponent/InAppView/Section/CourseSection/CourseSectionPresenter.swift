//
//  CourseSectionPresenter.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 14/9/2567 BE.
//

import Foundation

@MainActor
class CourseSectionPresenter: ObservableObject {
    // MARK: - Property
    @Published private(set) var sectionTitle: String?
    @Published private(set) var courseList: [CourseCardData] = []

    // MARK: - Init
    init(sectionTitle: String? = nil, courseList: [CourseCardData] = []) {
        self.sectionTitle = sectionTitle
        self.courseList = courseList
    }

    // MARK: - Event
    func setData(_ title: String?, _ list: [CourseCardData]) async {
        sectionTitle = title
        courseList = list
    }
}
