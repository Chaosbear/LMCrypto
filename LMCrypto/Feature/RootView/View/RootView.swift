//
//  RootView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 5/8/2567 BE.
//

import SwiftUI

struct RootView: View {
    // MARK: - Configure
    static func view() -> RootView {
        let rootPresenter = RootPresenter.shared
        let rootInteractor = RootInteractor.shared
        rootInteractor.presenter = rootPresenter

        let homePresenter = HomePresenter()
        let homeInteractor = HomeInteractor(
            presenter: homePresenter,
            layoutRepo: MockScreenLayoutRepository()
        )

        let searchPresenter = SearchPresenter()
        let searchInteractor = SearchInteractor(presenter: searchPresenter)

        let userLibraryPresenter = UserLibraryPresenter()
        let userLibraryInteractor = UserLibraryInteractor(presenter: userLibraryPresenter)

        let notificationPresenter = NotificationPresenter()
        let notificationInteractor = NotificationInteractor(presenter: notificationPresenter)

        return RootView(
            rootPresenter: rootPresenter,
            rootInteractor: rootInteractor,
            homePresenter: homePresenter,
            homeInteractor: homeInteractor,
            searchPresenter: searchPresenter,
            searchInteractor: searchInteractor,
            userLibraryPresenter: userLibraryPresenter,
            userLibraryInteractor: userLibraryInteractor,
            notificationPresenter: notificationPresenter,
            notificationInteractor: notificationInteractor
        )
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @StateObject private var rootPresenter: RootPresenter
    @State private var rootInteractor: RootInteractorProtocol

    @StateObject private var homePresenter: HomePresenter
    @State private var homeInteractor: HomeInteractorProtocol

    @StateObject private var searchPresenter: SearchPresenter
    @State private var searchInteractor: SearchInteractorProtocol

    @StateObject private var userLibraryPresenter: UserLibraryPresenter
    @State private var userLibraryInteractor: UserLibraryInteractorProtocol

    @StateObject private var notificationPresenter: NotificationPresenter
    @State private var notificationInteractor: NotificationInteractorProtocol

    // MARK: - Text Style
    private var itemTextStyle: TextStyler { TextStyler(
        font: theme.font.subTitle1.regular,
        color: theme.color.subTitle1
    )}

    // MARK: - Init
    init(
        rootPresenter: RootPresenter,
        rootInteractor: RootInteractorProtocol,
        homePresenter: HomePresenter,
        homeInteractor: HomeInteractorProtocol,
        searchPresenter: SearchPresenter,
        searchInteractor: SearchInteractorProtocol,
        userLibraryPresenter: UserLibraryPresenter,
        userLibraryInteractor: UserLibraryInteractorProtocol,
        notificationPresenter: NotificationPresenter,
        notificationInteractor: NotificationInteractorProtocol
    ) {
        self._rootPresenter = StateObject(wrappedValue: rootPresenter)
        self._rootInteractor = State(wrappedValue: rootInteractor)

        self._homePresenter = StateObject(wrappedValue: homePresenter)
        self._homeInteractor = State(wrappedValue: homeInteractor)

        self._searchPresenter = StateObject(wrappedValue: searchPresenter)
        self._searchInteractor = State(wrappedValue: searchInteractor)

        self._userLibraryPresenter = StateObject(wrappedValue: userLibraryPresenter)
        self._userLibraryInteractor = State(wrappedValue: userLibraryInteractor)

        self._notificationPresenter = StateObject(wrappedValue: notificationPresenter)
        self._notificationInteractor = State(wrappedValue: notificationInteractor)
    }

    // MARK: - UI Body
    var body: some View {
        ZStack(alignment: .bottom) {
            let tabBinding = Binding<RootViewTab>(
                get: {
                    rootPresenter.selectedTab
                }, set: { tab in
                    rootInteractor.selectTab(tab: tab)
                }
            )
            TabView(selection: tabBinding) {
                HomeView(
                    presenter: homePresenter,
                    interactor: homeInteractor
                )
                .tag(RootViewTab.home)
                SearchView(
                    presenter: searchPresenter,
                    interactor: searchInteractor
                )
                .tag(RootViewTab.search)
                UserLibraryView(
                    presenter: userLibraryPresenter,
                    interactor: userLibraryInteractor
                )
                .tag(RootViewTab.library)
                NotificationView(
                    presenter: notificationPresenter,
                    interactor: notificationInteractor
                )
                .tag(RootViewTab.notification)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(theme.color.background
                .frame(height: 56)
                .frameExpand(alignment: .top)
            )
            tabbar
        }
        .background(theme.color.background, ignoresSafeAreaEdges: [.horizontal, .bottom])
        .background(theme.color.background)
        .onViewDidLoad {
            homeInteractor.getData()
        }
    }

    // MARK: - UI Component
    @ViewBuilder
    private var tabbar: some View {
        let tabBinding = Binding<RootViewTab>(
            get: {
                rootPresenter.selectedTab
            }, set: { tab in
                rootInteractor.selectTab(tab: tab)
            }
        )
        RootTabbarView(selectedTab: tabBinding)
            .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    RootView.view()
}
