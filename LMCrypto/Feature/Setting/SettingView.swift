//
//  SettingView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import SwiftUI

struct SettingView: View {
    // MARK: - Route
    static func route() -> Route {
        let presenter = SettingPresenter()
        let interactor = SettingInteractor(presenter: presenter)

        let args = RouteArg()
        args.addPresenter(value: presenter)
        args.addInteractor(value: interactor)

        return Route.setting(args: args)
    }

    static func view(_ args: RouteArg) -> SettingView? {
        guard
            let presenter = args.presenter() as? SettingPresenter,
            let interactor = args.interactor() as? SettingInteractorProtocol
        else { return nil }

        return SettingView(
            presenter: presenter,
            interactor: interactor
        )
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var presenter: SettingPresenter
    private var interactor: SettingInteractorProtocol

    // MARK: - Init
    init(
        presenter: SettingPresenter,
        interactor: SettingInteractorProtocol
    ) {
        self.presenter = presenter
        self.interactor = interactor
    }

    // MARK: - Text Style

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("SettingView \(presenter.index)")

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
