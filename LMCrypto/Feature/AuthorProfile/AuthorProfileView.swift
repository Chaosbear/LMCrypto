//
//  AuthorProfileView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import SwiftUI

struct AuthorProfileView: View {
    // MARK: - Route
    static func route() -> Route {
        let presenter = AuthorProfilePresenter()
        let interactor = AuthorProfileInteractor(presenter: presenter)

        let args = RouteArg()
        args.addPresenter(value: presenter)
        args.addInteractor(value: interactor)

        return Route.authorProfile(args: args)
    }

    static func view(_ args: RouteArg) -> AuthorProfileView? {
        guard
            let presenter = args.presenter() as? AuthorProfilePresenter,
            let interactor = args.interactor() as? AuthorProfileInteractorProtocol
        else { return nil }

        return AuthorProfileView(
            presenter: presenter,
            interactor: interactor
        )
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var presenter: AuthorProfilePresenter
    private var interactor: AuthorProfileInteractorProtocol

    // MARK: - Init
    init(
        presenter: AuthorProfilePresenter,
        interactor: AuthorProfileInteractorProtocol
    ) {
        self.presenter = presenter
        self.interactor = interactor
    }

    // MARK: - Text Style

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("AuthorProfileView \(presenter.index)")

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
