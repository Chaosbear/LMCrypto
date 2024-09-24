//
//  ThemeSettingView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import SwiftUI

struct ThemeSettingView: View {
    // MARK: - Route
    static func route() -> Route {
        let presenter = ThemeSettingPresenter()
        let interactor = ThemeSettingInteractor(presenter: presenter)

        let args = RouteArg()
        args.addPresenter(value: presenter)
        args.addInteractor(value: interactor)

        return Route.themeSetting(args: args)
    }

    static func view(_ args: RouteArg) -> ThemeSettingView? {
        guard
            let presenter = args.presenter() as? ThemeSettingPresenter,
            let interactor = args.interactor() as? ThemeSettingInteractorProtocol
        else { return nil }

        return ThemeSettingView(
            presenter: presenter,
            interactor: interactor
        )
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var presenter: ThemeSettingPresenter
    private var interactor: ThemeSettingInteractorProtocol

    // MARK: - Init
    init(
        presenter: ThemeSettingPresenter,
        interactor: ThemeSettingInteractorProtocol
    ) {
        self.presenter = presenter
        self.interactor = interactor
    }

    // MARK: - Text Style

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("ThemeSettingView \(presenter.index)")

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
