//
//  HomeView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 30/8/2567 BE.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var presenter: HomePresenter
    private var interactor: HomeInteractorProtocol
    private let isPhone = isPhoneGlobal

    // MARK: - Init
    init(
        presenter: HomePresenter,
        interactor: HomeInteractorProtocol
    ) {
        self.presenter = presenter
        self.interactor = interactor
    }

    // MARK: - Text Style
    private var navTitleTextStyle: TextStyler { TextStyler(
        font: theme.font.h3.bold,
        color: theme.color.h1
    )}

    // MARK: - Layout
    private let sidePadding: CGFloat = isPhoneGlobal ? 12 : 40
    private var bannerWidth: CGFloat {
        if let deviceWidth = UIScreen.current?.deviceWidth() {
            let idealWidth = deviceWidth * 0.8
            return idealWidth > 320 ? 320 : idealWidth
        } else {
            return 320
        }
    }

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            navbar
            if presenter.isShowSkeleton {
                contentSkeleton
            } else {
                content
            }
        }
    }

    // MARK: - UI Component
    @ViewBuilder
    private var navbar: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .renderingMode(.template)
                .frame(width: 36, height: 36)
                .foregroundStyle(Color.gray)
                .clipShape(.circle)
                .frame(height: 56, alignment: .center)
                .padding(.leading, sidePadding)
                .padding(.trailing, 12)
                .contentShape(.rect)
                .asButton {
                    print("go to setting")
                }
            Text("Home")
                .modifier(navTitleTextStyle)
                .frameHorizontalExpand(alignment: .leading)
                .padding(.trailing, sidePadding)
        }
        .frame(height: 56, alignment: .center)
    }

    @ViewBuilder
    private var content: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(presenter.sectionList.indices, id: \.self) { index in
                    if let section = presenter.sectionList[safe: index] {
                        switch section.type {
                        case .userShortCut: 
                            userShortCutSection
                                .padding(.bottom, 12)
                        case .carouselBanner:
                            bannerSection
                                .padding(.bottom, 12)
                        case .horizontalArticle:
                            articleSection(section)
                                .padding(.bottom, 12)
                        case .horizontalCourse:
                            courseSection(section)
                                .padding(.bottom, 12)
                        }
                    }
                }
            }
            .padding(.bottom, 60)
        }
    }

    @ViewBuilder
    private var userShortCutSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: -20) {
                ForEach(0...8, id: \.self) { index in
                    Text("Hex \(index)")
                        .frame(width: 104, height: 90)
                        .background(theme.color.surface)
                        .chamferCorner(x: 26, y: 45, corners: .allCorners)
                        .shadow(color: theme.color.shadow, radius: 2, x: 1, y: 2)
                        .contentShape(ChampferRectangle(x: 26, y: 45, corners: .allCorners))
                        .asButton {
                            print("[devex] index: \(index)")
                        }
                        .padding(.top, index % 2 == 0 ? 0 : 45)
                }
            }
            .padding(.vertical, 2)
            .padding(.horizontal, isPhone ? 16 : 40)
        }
        .padding(.vertical, 14)
    }

    @ViewBuilder
    private var bannerSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 12) {
                ForEach(0...8, id: \.self) { index in
                    AsyncImage(url: nil) { phase in
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
                    .frame(width: bannerWidth, height: bannerWidth / 2)
                    .cornerRadius(12, corners: .allCorners)
                }
            }
            .padding(.vertical, 2)
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 14)
    }

    @ViewBuilder
    private func articleSection(_ section: ScreenSectionItemModel) -> some View {
        if let presenter = section.presenter as? ArticleSectionPresenter,
           let interactor = section.interactor as? ArticleSectionInteractorProtocol {
            ArticleSectionView(
                presenter: presenter,
                interactor: interactor,
                router: mainRouter
            )
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func courseSection(_ section: ScreenSectionItemModel) -> some View {
        if let presenter = section.presenter as? CourseSectionPresenter,
           let interactor = section.interactor as? CourseSectionInteractorProtocol {
            CourseSectionView(
                presenter: presenter,
                interactor: interactor,
                router: mainRouter
            )
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private var contentSkeleton: some View {
        ProgressView()
            .controlSize(.large)
            .frameExpand()
    }
}
