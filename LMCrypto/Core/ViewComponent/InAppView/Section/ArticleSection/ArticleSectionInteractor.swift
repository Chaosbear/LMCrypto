//
//  ArticleSectionInteractor.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 14/9/2567 BE.
//

import Foundation

protocol ArticleSectionInteractorProtocol {
    var presenter: ArticleSectionPresenter? { get set }
    func getList() async
}

class ArticleSectionInteractor: ArticleSectionInteractorProtocol {
    // MARK: - Property
    // data
    private var model: ScreenSectionModel

    // loading
    private var isLoadingList = false

    // dependency
    weak var presenter: ArticleSectionPresenter?
    private var articleRepo: ArticleRepositoryProtocol

    // MARK: - Init
    init(
        model: ScreenSectionModel,
        presenter: ArticleSectionPresenter?,
        articleRepo: ArticleRepositoryProtocol
    ) {
        self.model = model
        self.presenter = presenter
        self.articleRepo = articleRepo
    }

    // MARK: - Event
    func getList() async {
        guard !isLoadingList else { return }
        isLoadingList = true

        let data = await articleRepo.getArticleList(model, page: 1)
        let list = data.list.enumerated().map { (index, model) in
            ArticleCardData(id: index, model: model)
        }

        await presenter?.setData(model.title, list)

        isLoadingList = false
    }
}
