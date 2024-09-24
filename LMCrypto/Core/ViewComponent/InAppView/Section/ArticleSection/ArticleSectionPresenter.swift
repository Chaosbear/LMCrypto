//
//  ArticleSectionPresenter.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 14/9/2567 BE.
//

import Foundation

@MainActor
class ArticleSectionPresenter: ObservableObject {
    // MARK: - Property
    @Published private(set) var sectionTitle: String?
    @Published private(set) var articleList: [ArticleCardData] = []

    // MARK: - Init
//    init(sectionTitle: String? = nil, articleList: [ArticleCardData] = []) {
//        self.sectionTitle = sectionTitle
//        self.articleList = articleList
//    }

    // MARK: - Event
    func setData(_ title: String?, _ list: [ArticleCardData]) async {
        sectionTitle = title
        articleList = list
    }
}
