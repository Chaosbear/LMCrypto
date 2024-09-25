//
//  RootView.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

struct RootView: View {
    // MARK: - Configure
    static func view() -> RootView {
        let rootPresenter = RootPresenter.shared
        let rootInteractor = RootInteractor.shared
        rootInteractor.presenter = rootPresenter

        return RootView(
            rootPresenter: rootPresenter,
            rootInteractor: rootInteractor
        )
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @StateObject private var rootPresenter: RootPresenter
    @State private var rootInteractor: RootInteractorProtocol

    // MARK: - Text Style
    private var itemTextStyle: TextStyler { TextStyler(
        font: theme.font.h3.regular,
        color: theme.color.h3
    )}

    // MARK: - Init
    init(
        rootPresenter: RootPresenter,
        rootInteractor: RootInteractorProtocol
    ) {
        self._rootPresenter = StateObject(wrappedValue: rootPresenter)
        self._rootInteractor = State(wrappedValue: rootInteractor)
    }

    // MARK: - UI Body
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 12) {
                let mock1 = CoinCardData(
                    id: "1",
                    icon: nil,
                    symbol: "BTC",
                    symbolColor: Color("#f7931A"),
                    name: "BitCoin",
                    price: "$12,345.54321",
                    change: "0.72",
                    isUp: true
                )
                let mock2 = CoinCardData(
                    id: "2",
                    icon: nil,
                    symbol: "ETH",
                    symbolColor: Color("#f7931A"),
                    name: "Ethereum",
                    price: "$8,345.54321",
                    change: "2.80",
                    isUp: false
                )
                let mock3 = CoinCardData(
                    id: "3",
                    icon: nil,
                    symbol: "BNB",
                    symbolColor: Color("#f7931A"),
                    name: "Binance Coin",
                    price: "$898.54321",
                    change: "12.80",
                    isUp: true
                )
                HStack(alignment: .top, spacing: 8) {
                    TopCoinCardView(
                        data: mock1,
                        pressAction: {}
                    )
                    TopCoinCardView(
                        data: mock2,
                        pressAction: {}
                    )
                    TopCoinCardView(
                        data: mock3,
                        pressAction: {}
                    )
                }
                CoinCardView(
                    data: mock1,
                    pressAction: {}
                )
                CoinCardView(
                    data: mock2,
                    pressAction: {}
                )
                CoinCardView(
                    data: mock3,
                    pressAction: {}
                )

                ShareLink(item: URL(string: "https://careers.lmwn.com/")!, label: {
                    Label {
                        InviteCardView()
                    } icon: {
                        EmptyView()
                    }
                })

            }
            .padding(12)
        }
    }

    // MARK: - UI Component

}

#Preview {
    RootView.view()
}
