//
//  ArticleCardView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 10/9/2567 BE.
//

import SwiftUI

struct ArticleCardData: Identifiable {
    let id: Int
    let model: ArticleModel

    let title: String
    let description: String
    let image: URL?
    let updateAt: String
    let authorName: String
    let authorImage: URL?
    let likedCount: String
    let disLikedCount: String
    let commentCount: String
    let price: String?
    let originalPrice: String?

    init(id: Int, model: ArticleModel) {
        self.id = id
        self.model = model
        self.title = model.title
        self.description = model.descripton
        self.image = model.image?.imageUrl()
        self.updateAt = Utils.dateFormat(from: model.updatedAt, outFormat: .date) ?? ""
        self.authorName = model.authorName
        self.authorImage = model.authorImage.imageUrl()
        self.likedCount = Utils.numberFormatterWithSIPrefix(withNumber: model.engagement.liked)
        self.disLikedCount = Utils.numberFormatterWithSIPrefix(withNumber: model.engagement.disLiked)
        self.commentCount = Utils.numberFormatterWithSIPrefix(withNumber: model.engagement.comment)

        if !model.price.isFree() {
            self.price = Utils.numberFormatter(withNumber: model.price.total) + " \(model.price.currencySymbol)"
            if model.price.isDiscounting() {
                self.originalPrice = Utils.numberFormatter(withNumber: model.price.originalPrice) + " \(model.price.currencySymbol)"
            } else {
                self.originalPrice = nil
            }
        } else {
            self.price = nil
            self.originalPrice = nil
        }
    }
}

struct ArticleCardView: View {
    // MARK: - Property
    @EnvironmentObject var theme: ThemeState

    private let data: ArticleCardData
    private let pressAction: () -> Void

    // MARK: - Init
    init(data: ArticleCardData, pressAction: @escaping () -> Void) {
        self.data = data
        self.pressAction = pressAction
    }

    // MARK: - Text Style
    private var titleTextStyle: TextStyler { TextStyler(
        font: theme.font.h4.bold,
        color: theme.color.h3
    )}
    private var descriptionTextStyle: TextStyler { TextStyler(
        font: theme.font.body1.regular,
        color: theme.color.body1
    )}
    private var infoTextStyle: TextStyler { TextStyler(
        font: theme.font.caption.regular,
        color: theme.color.caption
    )}
    private var authorNameTextStyle: TextStyler { TextStyler(
        font: theme.font.body2.regular,
        color: theme.color.body1
    )}

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            articleContent
            articleInfo
        }
        .padding(16)
        .background(theme.color.surface)
        .cornerRadius(12, corners: .allCorners)
        .shadow(color: theme.color.shadow, radius: 2, x: 1, y: 2)
        .compositingGroup()
        .contentShape(.rect)
        .asButton {
            pressAction()
        }
    }

    // MARK: - UI Component
    @ViewBuilder
    private var articleContent: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                Text(data.title)
                    .modifier(titleTextStyle)
                    .lineLimit(2)
                Text(data.description)
                    .modifier(descriptionTextStyle)
                    .lineLimit(3)
            }
            .multilineTextAlignment(.leading)
            .lineSpacing(6)
            .frameHorizontalExpand(alignment: .leading)

            if let imageUrl = data.image {
                AsyncImage(url: imageUrl) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        AltImageView()
                    } else {
                        LoadImageView()
                    }
                }
                .frame(width: 80, height: 80)
                .cornerRadius(8, corners: .allCorners)
            }
        }
        .frame(height: 160, alignment: .top)
    }

    @ViewBuilder
    private var articleInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 4) {
                AsyncImage(url: data.image) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        AltImageView(image: "person.fill")
                    } else {
                        AltImageView(image: "person.fill")
                    }
                }
                .frame(width: 24, height: 24)
                .clipShape(.circle)

                Text(data.authorName)
                    .modifier(authorNameTextStyle)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(6)
            }
            HStack(alignment: .center, spacing: 8) {
                engagementInfo("hand.thumbsup", data.likedCount)
                engagementInfo("hand.thumbsdown", data.disLikedCount)
                engagementInfo("message", data.commentCount)

                Text(":")
                    .modifier(infoTextStyle)

                Text(data.updateAt)
                    .modifier(infoTextStyle)
                    .lineLimit(1)
            }
        }
    }

    @ViewBuilder
    private func engagementInfo(_ image: String, _ info: String) -> some View {
        HStack(alignment: .center, spacing: 4) {
            Image(systemName: image)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 16, height: 16)
                .foregroundStyle(theme.color.caption)
            Text(info)
                .modifier(infoTextStyle)
                .lineLimit(1)
        }
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack(alignment: .top, spacing: 12) {
            let mock = MockData.article
            ArticleCardView(data: .init(id: 0, model: mock), pressAction: {})
                .frame(width: 320)
            ArticleCardView(data: .init(id: 1, model: mock), pressAction: {})
                .frame(width: 320)
            ArticleCardView(data: .init(id: 2, model: mock), pressAction: {})
                .frame(width: 320)
        }
        .padding(12)
    }
    .environmentObject(ThemeState(
        font: DefaultFontTheme(),
        color: DefaultColorTheme()
    ))
}
