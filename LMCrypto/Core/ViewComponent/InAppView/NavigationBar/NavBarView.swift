//
//  NavBarView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 29/7/2567 BE.
//

import SwiftUI

struct NavBarView: View {
    // MARK: - Properties
    @EnvironmentObject var theme: ThemeState
    @ObservedObject var router: Router
    private let title: String
    private let hasBackBtn: Bool

    // MARK: - Layout
    private let navBarHeight: CGFloat = 56

    // MARK: - Text Style
    private var rootNavTitleTextStyle: TextStyler { TextStyler(
        font: theme.font.h3.bold,
        color: theme.color.h1
    )}
    private var navTitleTextStyle: TextStyler { TextStyler(
        font: theme.font.h6.bold,
        color: theme.color.h1
    )}

    // MARK: - Life Cycle
    init(
        title: String,
        hasBackBtn: Bool = true,
        router: Router
    ) {
        self.title = title
        self.hasBackBtn = hasBackBtn
        self.router = router
    }

    // MARK: - UI Body
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if hasBackBtn {
                Text(title)
                    .modifier(navTitleTextStyle)
                    .frameHorizontalExpand(alignment: .center)
                    .frame(height: navBarHeight, alignment: .center)
            } else {
                Text(title)
                    .modifier(rootNavTitleTextStyle)
                    .frameHorizontalExpand(alignment: .leading)
                    .frame(height: navBarHeight, alignment: .center)
            }
        }
        .padding(.horizontal, 12)
        .background(theme.color.background)
        .overlay(alignment: .leading) {
            if hasBackBtn {
                backBtn
            }
        }
    }

    // MARK: - UI Components
    @ViewBuilder
    private var backBtn: some View {
        Image(systemName: "chevron.left")
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundStyle(theme.color.primary)
            .frame(width: 44, height: 44)
            .contentShape(.rect)
            .asButton {
                router.navigateBack()
            }
            .padding(.trailing, 12)
    }
}
