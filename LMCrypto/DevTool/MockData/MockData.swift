//
//  MockData.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 15/9/2567 BE.
//

import Foundation

struct MockData {
    static var article: ArticleModel {
        ArticleModel(
            productId: "aaaaa",
            title: "Mock Article Card Data",
            descripton: "AsyncImage view uses the shared URLSession instance to load an image from the specified URL, and then display it. For example, you can display an icon that’s stored on a server",
            image: nil,
            updatedAt: "2024-08-05T00:00:00+07:00",
            authorName: "Anonymous Handsome Author",
            authorUserId: 1,
            authorImage: "",
            engagement: .init(liked: 9860, disLiked: 20, comment: 123),
            price: .init()
        )
    }

    static var course: CourseModel {
        CourseModel(
            productId: "aaaaa",
            title: "Mock Course Card Data",
            descripton: "AsyncImage view uses the shared URLSession instance to load an image from the specified URL, and then display it. For example, you can display an icon that’s stored on a server",
            image: nil,
            updatedAt: "2024-08-05T00:00:00+07:00",
            authorName: "Anonymous Handsome Author",
            authorUserId: 1,
            authorImage: "",
            engagement: .init(liked: 9860, disLiked: 20, comment: 123),
            totalStudent: 28321,
            rating: 4.8,
            totalReviewer: 16820,
            duration: 24000,
            price: .init()
        )
    }
}
