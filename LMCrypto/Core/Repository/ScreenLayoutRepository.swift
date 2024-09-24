//
//  ScreenLayoutRepository.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 8/9/2567 BE.
//

import Foundation

protocol ScreenLayoutRepositoryProtocol {
    func getHomeScreenLayout() async -> (ScreenLayoutModel, ApiResponseStatusModel)
}

struct MockScreenLayoutRepository: ScreenLayoutRepositoryProtocol {
    func getHomeScreenLayout() async -> (ScreenLayoutModel, ApiResponseStatusModel) {
        let mockUserShortCut = ScreenSectionModel(
            type: "userShortCut"
        )
        let mockArticle = ScreenSectionModel(
            type: "horizontalArticle",
            title: "Recently Read Article"
        )
        let mockBanner = ScreenSectionModel(
            type: "carouselBanner"
        )
        let mockArticle2 = ScreenSectionModel(
            type: "horizontalArticle",
            title: "Recoomend Article"
        )
        let mockCourse = ScreenSectionModel(
            type: "horizontalCourse",
            title: "Recoomend Course"
        )
        return (ScreenLayoutModel(totalSection: 5, list: [
            mockUserShortCut,
            mockArticle,
            mockBanner,
            mockArticle2,
            mockCourse
        ]), ApiResponseStatusModel(true, nil, 200))
    }
}
