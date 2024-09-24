//
//  HomeInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 30/8/2567 BE.
//

import Foundation

protocol HomeInteractorProtocol {
    var presenter: HomePresenter? { get set }

    func getData()
}

class HomeInteractor: HomeInteractorProtocol {
    // MARK: - Property
    // loading
    private var isLoading = false

    // dependency
    weak var presenter: HomePresenter?
    private var layoutRepo: ScreenLayoutRepositoryProtocol

    // MARK: - Init
    init(
        presenter: HomePresenter?,
        layoutRepo: ScreenLayoutRepositoryProtocol
    ) {
        self.presenter = presenter
        self.layoutRepo = layoutRepo
    }

    // MARK: - Event
    func getData() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            let data = await layoutRepo.getHomeScreenLayout()
            let sectionList = await mapLayoutToSection(data.0)
            let errState = ApiErrorState.defaultErrorHandler([data.1])

            await presenter?.setData(sectionList, errState)
        }

        isLoading = false
    }

    private func mapLayoutToSection(_ layout: ScreenLayoutModel) async -> [ScreenSectionItemModel] {
        var list: [ScreenSectionItemModel] = []

        for section in layout.list {
            guard let type = section.getType() else { continue }
            switch type {
            case .userShortCut:
                list.append(ScreenSectionItemModel(type: type))
            case .carouselBanner:
                list.append(ScreenSectionItemModel(type: type))
            case .horizontalArticle:
                let presenter = await ArticleSectionPresenter()
                let interactor = ArticleSectionInteractor(
                    model: section,
                    presenter: presenter,
                    articleRepo: MockArticleRepository()
                )

                list.append(ScreenSectionItemModel(
                    type: type,
                    presenter: presenter,
                    interactor: interactor
                ))
            case .horizontalCourse:
                let presenter = await CourseSectionPresenter()
                let interactor = CourseSectionInteractor(
                    model: section,
                    presenter: presenter,
                    courseRepo: MockCourseRepository()
                )

                list.append(ScreenSectionItemModel(
                    type: type,
                    presenter: presenter,
                    interactor: interactor
                ))
            }
        }

        await withTaskGroup(of: Void.self) { group in
            for sectionItem in list {
                switch sectionItem.type {
                case .userShortCut: continue
                case .carouselBanner: continue
                case .horizontalArticle:
                    if let interactor = sectionItem.interactor as? ArticleSectionInteractorProtocol {
                        group.addTask {
                            await interactor.getList()
                        }
                    }
                case .horizontalCourse:
                    if let interactor = sectionItem.interactor as? CourseSectionInteractorProtocol {
                        group.addTask {
                            await interactor.getList()
                        }
                    }
                }
            }
        }
        
        return list

//        return await withTaskGroup(
//            of: ScreenSectionItemModel.self,
//            returning: [ScreenSectionItemModel].self
//        ) { group in
//            let list = layout.list
//            debugPrint("[devex] list: \(list)")
//            for section in list {
//                if let type = section.getType() {
//                    group.addTask {
//                        switch type {
//                        case .userShortCut:
//                            return ScreenSectionItemModel(type: type)
//                        case .carouselBanner:
//                            return ScreenSectionItemModel(type: type)
//                        case .horizontalArticle:
//                            let presenter = await ArticleSectionPresenter()
//                            let interactor = ArticleSectionInteractor(
//                                model: section,
//                                presenter: presenter,
//                                articleRepo: MockArticleRepository()
//                            )
//
//                            await interactor.getList()
//
//                            return ScreenSectionItemModel(
//                                type: type,
//                                presenter: presenter,
//                                interactor: interactor
//                            )
//                        case .horizontalCourse:
//                            let presenter = await CourseSectionPresenter()
//                            let interactor = CourseSectionInteractor(
//                                model: section,
//                                presenter: presenter,
//                                courseRepo: MockCourseRepository()
//                            )
//
//                            await interactor.getList()
//
//                            return ScreenSectionItemModel(
//                                type: type,
//                                presenter: presenter,
//                                interactor: interactor
//                            )
//                        }
//                    }
//                }
//            }
//
//            var resultList: [ScreenSectionItemModel] = []
//            for await result in group {
//                resultList.append(result)
//            }
//            return resultList
//        }
    }
}
