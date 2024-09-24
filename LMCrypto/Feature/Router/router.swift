//
//  AppRouter.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 22/7/2567 BE.
//

import SwiftUI

protocol RouterProtocol {
    func dismiss(type: Router.NavigationType?)
    func dismissPresenting(type: Router.NavigationType?)

    func navigateTo(_ appRoute: Route)
    func navigateBack()
    func popToRoot()
    func presentSheet(_ route: Route)
    func presentFullScreen(_ route: Route)
}

class Router: ObservableObject, RouterProtocol {
    // MARK: - Type
    /// the different ways that can navigate to a view
    enum NavigationType {
        case push
        case sheet
        case fullScreenCover
    }

    // MARK: - Property
    /// Main Router
    static var main = Router(parent: nil)

    /// Used to programatically control navigation stack
    @Published var path: NavigationPath = NavigationPath()

    /// Used to present a view using a sheet
    var presentingSheet: Route?
    /// Used to present a view using a full screen cover
    var presentingFullScreenCover: Route?
    /// Used for access parent Router instances to dissmiss or navigate to other view
    private weak var parent: Router?

    // MARK: - Life Cycle
    init(parent: Router?) {
        self.parent = parent
    }

    // MARK: - Action: Navigation
    /// Dismisses self when self is presented by sheet or fullScreenCover
    func dismiss(type: NavigationType? = nil) {
        parent?.dismissPresenting(type: type)
    }

    /// Dismisses presented screen
    func dismissPresenting(type: NavigationType? = nil) {
        if type == .sheet {
            if presentingSheet != nil {
                presentingSheet = nil
            }
        } else if type == .fullScreenCover {
            if presentingFullScreenCover != nil {
                presentingFullScreenCover = nil
            }
        } else {
            if presentingSheet != nil {
                presentingSheet = nil
            }
            if presentingFullScreenCover != nil {
                presentingFullScreenCover = nil
            }
        }
    }

    /// Used to navigate to another view
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }

    /// Used to go back to the previous screen
    func navigateBack() {
        path.removeLast()
    }

    /// Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }

    /// Used to present a screen using a sheet
    func presentSheet(_ route: Route) {
        self.presentingSheet = route
    }

    /// Used to present a screen using a full screen cover
    func presentFullScreen(_ route: Route) {
        self.presentingFullScreenCover = route
    }
}

// MARK: - Action: Build View
extension Router {
    @ViewBuilder
    func view(for route: Route, type: NavigationType) -> some View {
        switch route {
        case .profile(let args):
            ProfileView.view(args)
        case .authorProfile(let args):
            AuthorProfileView.view(args)
        case .article(let args):
            ArticleView.view(args)
        case .course(let args):
            CourseView.view(args)
        case .setting(let args):
            SettingView.view(args)
        case .themeSetting(let args):
            ThemeSettingView.view(args)
        }
    }
}
