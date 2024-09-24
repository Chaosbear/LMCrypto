//
//  RootTabbarView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 15/8/2567 BE.
//

import SwiftUI

enum RootViewTab: String, CaseIterable {
    case home
    case search
    case library
    case notification

    var title: String {
        switch self {
        case .home: "Home"
        case .search: "Search"
        case .library: "Library"
        case .notification: "Notification"
        }
    }

    var icon: String {
        switch self {
        case .home: "house"
        case .search: "magnifyingglass"
        case .library: "books.vertical"
        case .notification: "bell"
        }
    }
}

struct RootTabbarView: View {
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @Binding var selectedTab: RootViewTab

    private let isPhone = isPhoneGlobal

    private var titleTextStyle: TextStyler {
        TextStyler(
            font: theme.font.subTitle2.regular,
            color: theme.color.neutral
        )
    }
    private var selectedTitleTextStyle: TextStyler {
        TextStyler(
            font: theme.font.subTitle2.regular,
            color: theme.color.primary
        )
    }

    init(selectedTab: Binding<RootViewTab>) {
        self._selectedTab = selectedTab
    }

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(RootViewTab.allCases, id: \.self) { tab in
                VStack(alignment: .center, spacing: 4) {
                    Image(systemName: tab.icon)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(tab == selectedTab ? theme.color.primary : theme.color.neutral)
                        .frame(
                            width: isPhone ? 20 : 28,
                            height: isPhone ? 20 : 28
                        )
                    Text(tab.title)
                        .modifier(tab == selectedTab ? selectedTitleTextStyle : titleTextStyle)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                .padding(.vertical, 4)
                .frameHorizontalExpand(alignment: .center)
                .contentShape(.rect)
                .asButton {
                    if selectedTab != tab {
                        selectedTab = tab
                    }
                }
            }
        }
        .animation(.default, value: selectedTab)
        .padding(.top, 24)
        .background(LinearGradient(
            colors: [
                theme.color.background.opacity(0),
                theme.color.background.opacity(0.4),
                theme.color.background.opacity(0.6),
                theme.color.background.opacity(0.8),
                theme.color.background
            ],
            startPoint: .top,
            endPoint: .bottom
        ))
    }
}

#Preview {
    RootTabbarView(selectedTab: .constant(.home))
}
