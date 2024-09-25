//
//  CoinDetailView.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 25/9/2567 BE.
//

import SwiftUI

struct CoinDetailView: View {
    // MARK: - Configure
    static func view(id: String) -> CoinDetailView {
        let presenter = CoinDetailPresenter()
        let interactor = CoinDetailInteractor(coinId: id)
        interactor.presenter = presenter

        return CoinDetailView(
            presenter: presenter,
            interactor: interactor
        )
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState
    @Environment(\.openURL) var openURL

    @StateObject private var presenter: CoinDetailPresenter
    @State private var interactor: CoinDetailInteractorProtocol

    // MARK: - Text Style
    private var nameTextStyle: TextStyler { TextStyler(
        font: theme.font.h2.bold,
        color: presenter.coinDetail?.nameColor ?? Color(Palette.black)
    )}
    private var symbolTextStyle: TextStyler { TextStyler(
        font: theme.font.h3.regular,
        color: Color(Palette.black)
    )}
    private var labelTextStyle: TextStyler { TextStyler(
        font: theme.font.h5.bold,
        color: Color(Palette.nightRiderGray)
    )}
    private var priceTextStyle: TextStyler { TextStyler(
        font: theme.font.h5.regular,
        color: Color(Palette.nightRiderGray)
    )}
    private var descriptionTextStyle: TextStyler { TextStyler(
        font: theme.font.h4.regular,
        color: Color(Palette.coolGray)
    )}
    private var websiteTextStyle: TextStyler { TextStyler(
        font: theme.font.h4.bold,
        color: Color(Palette.brilliantAzure)
    )}

    // MARK: - Init
    init(
        presenter: CoinDetailPresenter,
        interactor: CoinDetailInteractorProtocol
    ) {
        self._presenter = StateObject(wrappedValue: presenter)
        self._interactor = State(wrappedValue: interactor)
    }

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 16) {
                    conInfo
                    Text(presenter.coinDetail?.description ?? "")
                        .modifier(descriptionTextStyle)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(6)
                }
                .frameHorizontalExpand(alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.vertical, 32)
            }

            if let webUrl = presenter.coinDetail?.coinWebsite {
                Divider()
                    .ignoresSafeArea(.all, edges: .horizontal)

                Text("GO TO WEBSITE")
                    .modifier(websiteTextStyle)
                    .frame(height: 48, alignment: .center)
                    .frameHorizontalExpand(alignment: .center)
                    .contentShape(.rect)
                    .asButton {
                        openURL(webUrl)
                    }
            }
        }
        .background(Color(Palette.white))
        .onViewDidLoad {
            interactor.loadData()
        }
    }

    // MARK: - UI Component
    @ViewBuilder
    private var conInfo: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: presenter.coinDetail?.icon) { phase in
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
            .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .bottom, spacing: 4) {
                    Text(presenter.coinDetail?.name ?? "")
                        .modifier(nameTextStyle)
                    Text("(\(presenter.coinDetail?.symbol ?? ""))")
                        .modifier(symbolTextStyle)
                }
                HStack(alignment: .bottom, spacing: 8) {
                    Text("PRICE")
                        .modifier(labelTextStyle)
                    Text(presenter.coinDetail?.price ?? "")
                        .modifier(priceTextStyle)
                }
                HStack(alignment: .bottom, spacing: 8) {
                    Text("MARKET CAP")
                        .modifier(labelTextStyle)
                    Text(presenter.coinDetail?.marketCap ?? "")
                        .modifier(priceTextStyle)
                }
            }
            .lineLimit(1)
            .minimumScaleFactor(0.6)
        }
    }
}

#Preview {
    CoinDetailView.view(id: "Bitcoin")
}

