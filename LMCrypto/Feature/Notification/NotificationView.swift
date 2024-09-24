//
//  NotificationView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import SwiftUI

struct NotificationView: View {
    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var presenter: NotificationPresenter
    private var interactor: NotificationInteractorProtocol

    // MARK: - Init
    init(
        presenter: NotificationPresenter,
        interactor: NotificationInteractorProtocol
    ) {
        self.presenter = presenter
        self.interactor = interactor
    }

    // MARK: - Text Style

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("Notification \(presenter.index)")

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

