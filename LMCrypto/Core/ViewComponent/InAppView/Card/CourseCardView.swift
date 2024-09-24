//
//  CourseCardView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 10/9/2567 BE.
//

import SwiftUI

struct CourseCardData: Identifiable {
    let id: Int
    let model: CourseModel

    let title: String
    let image: URL?
    let updateAt: String
    let authorName: String
    let authorImage: URL?
    let ratingScore: String
    let totalReviewer: String
    let duration: String
    let price: String?
    let originalPrice: String?

    init(id: Int, model: CourseModel) {
        self.id = id
        self.model = model
        self.title = model.title
        self.image = model.image?.imageUrl()
        self.updateAt = Utils.dateFormat(from: model.updatedAt, outFormat: .date) ?? ""
        self.authorName = model.authorName
        self.authorImage = model.authorImage.imageUrl()
        self.ratingScore = Utils.numberFormatter(withNumber: model.rating, decimal: 1)
        self.totalReviewer = Utils.numberFormatterWithSIPrefix(
            withNumber: model.totalReviewer,
            showZeroDecimal: true
        )

        if model.duration >= 3600 {
            self.duration = "\(Utils.numberFormatter(withNumber: Double(model.duration) / 3600.0, decimal: 1)) hours"
        } else {
            self.duration = "\(Utils.numberFormatter(withNumber: Double(model.duration) / 60.0, decimal: 1)) minutes"
        }

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

struct CourseCardView: View {
    // MARK: - Property
    @EnvironmentObject var theme: ThemeState

    private let data: CourseCardData
    private let pressAction: () -> Void

    // MARK: - Init
    init(data: CourseCardData, pressAction: @escaping () -> Void) {
        self.data = data
        self.pressAction = pressAction
    }

    // MARK: - Text Style
    private var titleTextStyle: TextStyler { TextStyler(
        font: theme.font.h4.bold,
        color: theme.color.h3
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
        VStack(alignment: .leading, spacing: 0) {
            courseImage
            courseInfo
                .padding(16)
        }
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
    private var courseImage: some View {
        AsyncImage(url: data.image) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                AltImageView(maxWidth: 120)
            } else {
                AltImageView(maxWidth: 120)
            }
        }
        .aspectRatio(2, contentMode: .fit)
        .clipped()
    }

    @ViewBuilder
    private var courseInfo: some View {
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
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color.yellow)
                        .padding(.bottom, 2)
                    Text(data.ratingScore)
                        .modifier(infoTextStyle)
                        .lineLimit(1)
                    Text("(\(data.totalReviewer))")
                        .modifier(infoTextStyle)
                        .lineLimit(1)
                }

                Text(data.duration)
                    .modifier(infoTextStyle)
                    .lineLimit(1)

                Text(":")
                    .modifier(infoTextStyle)

                Text(data.updateAt)
                    .modifier(infoTextStyle)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack(alignment: .top, spacing: 12) {
            let mock = MockData.course
            CourseCardView(data: .init(id: 0, model: mock), pressAction: {})
                .frame(width: 320)
            CourseCardView(data: .init(id: 1, model: mock), pressAction: {})
                .frame(width: 320)
            CourseCardView(data: .init(id: 2, model: mock), pressAction: {})
                .frame(width: 320)
        }
        .padding(12)
    }
    .environmentObject(ThemeState(
        font: DefaultFontTheme(),
        color: DefaultColorTheme()
    ))
}

