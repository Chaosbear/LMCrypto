//
//  CoinCardView.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

struct CoinCardData: Identifiable {
    let id: String
    let icon: URL?
    let symbol: String
    let symbolColor: Color
    let name: String
    let price: String
    let change: String
    let isUp: Bool

    init(model: CoinModel) {
        self.id = model.uuid
        self.icon = model.iconUrl.imageUrl()
        self.symbol = model.symbol
        self.symbolColor = Color(model.color)
        self.name = model.name
        self.price = "$" + Utils.numberFormatter(withNumber: model.price, decimal: 5)

        let change = Double(model.change) ?? 0
        self.change = Utils.numberFormatter(withNumber: abs(change), decimal: 2)
        self.isUp = change >= 0
    }

    init(
        id: String,
        icon: URL?,
        symbol: String,
        symbolColor: Color,
        name: String,
        price: String,
        change: String,
        isUp: Bool
    ) {
        self.id = id
        self.icon = icon
        self.symbol = symbol
        self.symbolColor = symbolColor
        self.name = name
        self.price = price
        self.change = change
        self.isUp = isUp
    }
}

struct CoinCardView: View {
    // MARK: - Property
    @EnvironmentObject var theme: ThemeState

    private let data: CoinCardData
    private let pressAction: () -> Void

    // MARK: - Init
    init(data: CoinCardData, pressAction: @escaping () -> Void) {
        self.data = data
        self.pressAction = pressAction
    }

    // MARK: - Text Style
    private var nameTextStyle: TextStyler { TextStyler(
        font: theme.font.h3.bold,
        color: Color(Palette.nightRiderGray)
    )}
    private var symbolTextStyle: TextStyler { TextStyler(
        font: theme.font.h4.bold,
        color: Color(Palette.coolGray)
    )}
    private var priceTextStyle: TextStyler { TextStyler(
        font: theme.font.h5.bold,
        color: Color(Palette.nightRiderGray)
    )}
    private var changeUpTextStyle: TextStyler { TextStyler(
        font: theme.font.h5.bold,
        color: Color(Palette.vividMalachite)
    )}
    private var changeDownTextStyle: TextStyler { TextStyler(
        font: theme.font.h5.bold,
        color: Color(Palette.deepCarminePink)
    )}

    // MARK: - UI Body
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            coinIcon
            VStack(alignment: .leading, spacing: 6) {
                coinName
                coinSymbol
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(theme.color.surface)
        .cornerRadius(8, corners: .allCorners)
        .shadow(color: theme.color.shadow.opacity(0.1), radius: 2, x: 0, y: 2)
        .contentShape(.rect)
        .asButton {
            pressAction()
        }
    }

    // MARK: - UI Component
    @ViewBuilder
    private var coinIcon: some View {
        AsyncImage(url: data.icon) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                AltImageView()
                    .cornerRadius(8, corners: .allCorners)
            } else {
                LoadImageView(false)
                    .cornerRadius(8, corners: .allCorners)
            }
        }
        .frame(width: 40, height: 40)
    }

    @ViewBuilder
    private var coinName: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Text(data.name)
                .modifier(nameTextStyle)
                .frameHorizontalExpand(alignment: .leading)
            Text(data.price)
                .modifier(priceTextStyle)
                .fixedSize(horizontal: true, vertical: false)
        }
        .lineLimit(1)
    }

    @ViewBuilder
    private var coinSymbol: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Text(data.symbol)
                .modifier(symbolTextStyle)
                .frameHorizontalExpand(alignment: .leading)
            HStack(alignment: .center, spacing: 2) {
                Image("icon_arrow")
                    .resizable()
                    .renderingMode(.template)
                    .rotationEffect(.degrees(data.isUp ? 0 : 180))
                    .frame(width: 12, height: 12)
                    .foregroundStyle(data.isUp ? Color(Palette.vividMalachite) : Color(Palette.deepCarminePink))
                Text(data.change)
                    .modifier(data.isUp ? changeUpTextStyle : changeDownTextStyle)
            }
            .fixedSize(horizontal: true, vertical: false)
        }
        .lineLimit(1)
    }
}

struct TopCoinCardView: View {
    // MARK: - Property
    @EnvironmentObject var theme: ThemeState

    private let data: CoinCardData
    private let pressAction: () -> Void

    // MARK: - Init
    init(data: CoinCardData, pressAction: @escaping () -> Void) {
        self.data = data
        self.pressAction = pressAction
    }

    // MARK: - Text Style
    private var symbolTextStyle: TextStyler { TextStyler(
        font: theme.font.h5.bold,
        color: data.symbolColor
    )}
    private var nameTextStyle: TextStyler { TextStyler(
        font: theme.font.h4.regular,
        color: Color(Palette.coolGray)
    )}
    private var changeUpTextStyle: TextStyler { TextStyler(
        font: theme.font.h5.bold,
        color: Color(Palette.vividMalachite)
    )}
    private var changeDownTextStyle: TextStyler { TextStyler(
        font: theme.font.h5.bold,
        color: Color(Palette.deepCarminePink)
    )}

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            coinIcon

            Text(data.symbol)
                .modifier(symbolTextStyle)

            Text(data.name)
                .modifier(nameTextStyle)

            HStack(alignment: .center, spacing: 2) {
                Image("icon_arrow")
                    .resizable()
                    .renderingMode(.template)
                    .rotationEffect(.degrees(data.isUp ? 0 : 180))
                    .frame(width: 12, height: 12)
                    .foregroundStyle(data.isUp ? Color(Palette.vividMalachite) : Color(Palette.deepCarminePink))
                Text(data.change)
                    .modifier(data.isUp ? changeUpTextStyle : changeDownTextStyle)
            }
            .fixedSize(horizontal: true, vertical: false)
        }
        .lineLimit(1, reservesSpace: true)
        .padding(16)
        .frameHorizontalExpand()
        .background(theme.color.surface)
        .cornerRadius(8, corners: .allCorners)
        .shadow(color: theme.color.shadow.opacity(0.1), radius: 2, x: 0, y: 2)
        .contentShape(.rect)
        .asButton {
            pressAction()
        }
    }

    // MARK: - UI Component
    @ViewBuilder
    private var coinIcon: some View {
        AsyncImage(url: data.icon) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                AltImageView()
                    .cornerRadius(8, corners: .allCorners)
            } else {
                LoadImageView(false)
                    .cornerRadius(8, corners: .allCorners)
            }
        }
        .frame(width: 40, height: 40)
    }
}

#Preview {
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
        }
        .padding(12)
    }
    .environmentObject(ThemeState(
        font: DefaultFontTheme(),
        color: DefaultColorTheme()
    ))
}
