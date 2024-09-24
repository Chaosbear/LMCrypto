//
//  ArticleRepository.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 14/9/2567 BE.
//

import Foundation

protocol ArticleRepositoryProtocol {
    func getArticleList(_ model: ScreenSectionModel, page: Int) async -> ArticleListModel
}

struct MockArticleRepository: ArticleRepositoryProtocol {
    func getArticleList(_ model: ScreenSectionModel, page: Int) async -> ArticleListModel {
        let mockArticle = MockData.article
        return ArticleListModel(
            page: .init(),
            list: [
                mockArticle,
                mockArticle,
                mockArticle,
                mockArticle,
                mockArticle,
                mockArticle,
                mockArticle,
                mockArticle,
                mockArticle,
                mockArticle
            ]
        )
    }
}
