//
//  ArticleView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import SwiftUI

struct ArticleView: View {
    // MARK: - Route
    static func route() -> Route {
        let presenter = ArticlePresenter()
        let interactor = ArticleInteractor(presenter: presenter)

        let args = RouteArg()
        args.addPresenter(value: presenter)
        args.addInteractor(value: interactor)

        return Route.article(args: args)
    }

    static func view(_ args: RouteArg) -> ArticleView? {
        guard
            let presenter = args.presenter() as? ArticlePresenter,
            let interactor = args.interactor() as? ArticleInteractorProtocol
        else { return nil }

        return ArticleView(
            presenter: presenter,
            interactor: interactor
        )
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var presenter: ArticlePresenter
    private var interactor: ArticleInteractorProtocol

    // MARK: - Init
    init(
        presenter: ArticlePresenter,
        interactor: ArticleInteractorProtocol
    ) {
        self.presenter = presenter
        self.interactor = interactor
    }

    // MARK: - Text Style

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("ArticleView \(presenter.index)")

            Text("Count \(presenter.count)")
            Text("+")
                .foregroundStyle(Color.white)
                .frame(width: 80, height: 50, alignment: .center)
                .background(Color.blue)
                .cornerRadius(8, corners: .allCorners)
                .contentShape(.rect)
                .asButton {
                    interactor.tapIncrease()
                }
        }
        .frameExpand(alignment: .center)
        .toolbar(.hidden, for: .navigationBar)

    }
}
