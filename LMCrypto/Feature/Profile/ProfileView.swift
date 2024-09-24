//
//  ProfileView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - Route
    static func route() -> Route {
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor(presenter: presenter)

        let args = RouteArg()
        args.addPresenter(value: presenter)
        args.addInteractor(value: interactor)

        return Route.profile(args: args)
    }

    static func view(_ args: RouteArg) -> ProfileView? {
        guard
            let presenter = args.presenter() as? ProfilePresenter,
            let interactor = args.interactor() as? ProfileInteractorProtocol
        else { return nil }

        return ProfileView(
            presenter: presenter,
            interactor: interactor
        )
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var presenter: ProfilePresenter
    private var interactor: ProfileInteractorProtocol

    // MARK: - Init
    init(
        presenter: ProfilePresenter,
        interactor: ProfileInteractorProtocol
    ) {
        self.presenter = presenter
        self.interactor = interactor
    }

    // MARK: - Text Style

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("ProfileView \(presenter.index)")

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
