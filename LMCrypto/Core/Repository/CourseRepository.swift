//
//  CourseRepository.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 14/9/2567 BE.
//

import Foundation

protocol CourseRepositoryProtocol {
    func getCourseList(_ model: ScreenSectionModel, page: Int) async -> CourseListModel
}

struct MockCourseRepository: CourseRepositoryProtocol {
    func getCourseList(_ model: ScreenSectionModel, page: Int) async -> CourseListModel {
        let mockCourse = MockData.course
        return CourseListModel(
            page: .init(),
            list: [
                mockCourse,
                mockCourse,
                mockCourse,
                mockCourse,
                mockCourse,
                mockCourse,
                mockCourse,
                mockCourse,
                mockCourse,
                mockCourse
            ]
        )
    }
}
