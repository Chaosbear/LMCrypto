//
//  SearchView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 7/9/2567 BE.
//

import SwiftUI

struct SearchView: View {
    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var presenter: SearchPresenter
    private var interactor: SearchInteractorProtocol

    // MARK: - Init
    init(
        presenter: SearchPresenter,
        interactor: SearchInteractorProtocol
    ) {
        self.presenter = presenter
        self.interactor = interactor
    }

    // MARK: - Text Style

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("Search \(presenter.index)")

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
