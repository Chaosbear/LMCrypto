//
//  CourseSectionInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 14/9/2567 BE.
//

import Foundation

protocol CourseSectionInteractorProtocol {
    var presenter: CourseSectionPresenter? { get set }
    func getList() async
}

class CourseSectionInteractor: CourseSectionInteractorProtocol {
    // MARK: - Property
    // data
    private var model: ScreenSectionModel

    // loading
    private var isLoadingList = false

    // dependency
    weak var presenter: CourseSectionPresenter?
    private var courseRepo: CourseRepositoryProtocol

    // MARK: - Init
    init(
        model: ScreenSectionModel,
        presenter: CourseSectionPresenter?,
        courseRepo: CourseRepositoryProtocol
    ) {
        self.model = model
        self.presenter = presenter
        self.courseRepo = courseRepo
    }

    // MARK: - Event
    func getList() async {
        guard !isLoadingList else { return }
        isLoadingList = true

        let data = await courseRepo.getCourseList(model, page: 1)
        let list = data.list.enumerated().map { (index, model) in
            CourseCardData(id: index, model: model)
        }

        await presenter?.setData(model.title, list)

        isLoadingList = false
    }
}
