//
//  ArticleSectionView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 13/9/2567 BE.
//

import SwiftUI

struct ArticleSectionView: View {
    // MARK: - Property
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var presenter: ArticleSectionPresenter
    private var interactor: ArticleSectionInteractorProtocol
    private var router: Router

    // MARK: - Init
    init(
        presenter: ArticleSectionPresenter,
        interactor: ArticleSectionInteractorProtocol,
        router: Router
    ) {
        self.presenter = presenter
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Text Style
    private var titleTextStyle: TextStyler { TextStyler(
        font: theme.font.h4.bold,
        color: theme.color.h3
    )}

    // MARK: - Layout
    private let sidePadding: CGFloat = isPhoneGlobal ? 16 : 40
    private var cardWidth: CGFloat {
        if let deviceWidth = UIScreen.current?.deviceWidth() {
            let idealWidth = deviceWidth * 0.8
            return idealWidth > 320 ? 320 : idealWidth
        } else {
            return 320
        }
    }

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title = presenter.sectionTitle {
                Text(title)
                    .modifier(titleTextStyle)
                    .lineLimit(1)
                    .frameHorizontalExpand(alignment: .leading)
                    .padding(.horizontal, sidePadding)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(presenter.articleList) { data in
                        ArticleCardView(data: data) {
                            print("[devex] tap article card")
                        }
                        .frame(width: cardWidth)
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, sidePadding)
            }
        }
    }
}

#Preview {
    ScrollView(.vertical) {
        ArticleSectionView(
            presenter: ArticleSectionPresenter(),
            interactor: ArticleSectionInteractor(
                model: .init(),
                presenter: ArticleSectionPresenter(),
                articleRepo: MockArticleRepository()),
            router: Router(parent: nil)
        )
        .padding(.vertical, 80)
    }
    .environmentObject(ThemeState(
        font: DefaultFontTheme(),
        color: DefaultColorTheme()
    ))
}
