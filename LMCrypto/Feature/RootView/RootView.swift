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

    // MARK: - Type
    enum TextFieldType: Int, Hashable {
        case search
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @StateObject private var rootPresenter: RootPresenter
    @State private var rootInteractor: RootInteractorProtocol

    @FocusState private var focusedField: TextFieldType?
    @State private var searchText: String = ""

    // MARK: - Text Style
    private var searchTextStyle: TextStyler { TextStyler(
        font: theme.font.body2.regular,
        color: Color(Palette.black)
    )}
    private var headerTextStyle: TextStyler { TextStyler(
        font: theme.font.h3.bold,
        color: Color(Palette.black)
    )}
    private var topNumberTextStyle: TextStyler { TextStyler(
        font: theme.font.h4.bold,
        color: Color(Palette.fireEngineRed)
    )}
    private var headerDescTextStyle: TextStyler { TextStyler(
        font: .system(size: 16, weight: .semibold),
        color: Color(Palette.black)
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
        VStack(alignment: .leading, spacing: 0) {
            searchBar
                .padding(16)
            Divider()
                .ignoresSafeArea(.all, edges: .horizontal)
            coinContent
        }
        .background(
            Color(Palette.white)
                .onTapGesture {
                    focusedField = nil
                }
        )
        .onViewDidLoad {
            rootInteractor.loadAllData()
            print("[lmwn] \(Config.enableNetFox)")
            print("[lmwn] \(Config.useMockData)")
        }
    }

    // MARK: - UI Component
    @ViewBuilder
    private var searchBar: some View {
        HStack(alignment: .center, spacing: 0) {
            Image("icon_magnify")
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundStyle(Color(Palette.silverSand))
                .padding(12)
                .contentShape(.rect)
                .onTapGesture {
                    focusedField = .search
                }
            let searchBinding = Binding<String>(
                get: { searchText },
                set: { value in
                    searchText = value
                    rootInteractor.searchText = value
                }
            )
            TextField("Search", text: searchBinding)
                .modifier(searchTextStyle)
                .focused($focusedField, equals: .search)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(.plain)
                .submitLabel(.search)
                .padding(.vertical, 12)
            Image("icon_cancel")
                .resizable()
                .frame(width: 16, height: 16)
                .padding(css: 16, 16, 16, 12)
                .contentShape(.rect)
                .asButton {
                    searchText = ""
                    rootInteractor.clearSearchText()
                }
                .opacity(focusedField == .search ? 1 : 0)
        }
        .background(Color(Palette.brightGray).onTapGesture {
            focusedField = .search
        })
        .cornerRadius(8, corners: .allCorners)
    }

    @ViewBuilder
    private var coinContent: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 22) {
                topCoin
                    .padding(.top, 16)
                coinList
                    .padding(.bottom, 24)
            }
        }
    }

    @ViewBuilder
    private var topCoin: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .bottom, spacing: 0) {
                Text("Top")
                    .modifier(headerTextStyle)
                Text(" 3 ")
                    .modifier(topNumberTextStyle)
                Text("rank crypto")
                    .modifier(headerDescTextStyle)
            }
            .frameHorizontalExpand(alignment: .leading)
            .padding(.horizontal, 16)

            HStack(alignment: .top, spacing: 8) {
                ForEach(rootPresenter.topCoinList) { item in
                    TopCoinCardView(
                        data: item.cardData,
                        pressAction: {
                            focusedField = nil
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
        }
    }

    @ViewBuilder
    private var coinList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Buy, sell and hold crypto")
                .modifier(headerTextStyle)
                .frameHorizontalExpand(alignment: .leading)
                .padding(.horizontal, 16)

            LazyVStack(alignment: .leading, spacing: 12) {
                ShareLink(item: URL(string: "https://careers.lmwn.com/")!, label: {
                    Label {
                        InviteCardView()
                    } icon: {
                        EmptyView()
                    }
                })

                ForEach(rootPresenter.coinList) { item in
                    CoinCardView(
                        data: item.cardData,
                        pressAction: {
                            focusedField = nil
                        }
                    )
                    .onAppear {
                        if item.id == rootPresenter.coinList.last?.id {
                            rootInteractor.loadMoreList()
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    RootView.view()
}
