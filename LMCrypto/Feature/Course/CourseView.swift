//
//  CourseView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import SwiftUI

struct CourseView: View {
    // MARK: - Route
    static func route() -> Route {
        let presenter = CoursePresenter()
        let interactor = CourseInteractor(presenter: presenter)

        let args = RouteArg()
        args.addPresenter(value: presenter)
        args.addInteractor(value: interactor)

        return Route.course(args: args)
    }

    static func view(_ args: RouteArg) -> CourseView? {
        guard
            let presenter = args.presenter() as? CoursePresenter,
            let interactor = args.interactor() as? CourseInteractorProtocol
        else { return nil }

        return CourseView(
            presenter: presenter,
            interactor: interactor
        )
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var presenter: CoursePresenter
    private var interactor: CourseInteractorProtocol

    // MARK: - Init
    init(
        presenter: CoursePresenter,
        interactor: CourseInteractorProtocol
    ) {
        self.presenter = presenter
        self.interactor = interactor
    }

    // MARK: - Text Style

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("CourseView \(presenter.index)")

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
