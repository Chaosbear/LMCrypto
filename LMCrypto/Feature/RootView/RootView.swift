//
//  RootView.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

struct RootView: View {
    // MARK: - Configure
    static func view(
        presenter: RootPresenter,
        interactor: RootInteractorProtocol
    ) -> RootView {

        interactor.presenter = presenter

        return RootView(
            rootPresenter: presenter,
            rootInteractor: interactor
        )
    }

    // MARK: - Type
    enum TextFieldType: Int, Hashable {
        case search
    }

    // MARK: - Property
    @EnvironmentObject var mainRouter: Router
    @EnvironmentObject var theme: ThemeState

    @ObservedObject private var rootPresenter: RootPresenter
    private var rootInteractor: RootInteractorProtocol

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
        font: theme.font.h2.bold,
        color: Color(Palette.fireEngineRed)
    )}
    private var headerDescTextStyle: TextStyler { TextStyler(
        font: .system(size: 16, weight: .medium),
        color: Color(Palette.black)
    )}

    // MARK: - Init
    init(
        rootPresenter: RootPresenter,
        rootInteractor: RootInteractorProtocol
    ) {
        self.rootPresenter = rootPresenter
        self.rootInteractor = rootInteractor
    }

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            searchBar
                .padding(16)
            Divider()
                .ignoresSafeArea(.all, edges: .horizontal)

            if rootPresenter.isShowSkeleton {
                contentSkeleton
                    .transition(.opacity.animation(.linear(duration: 0.2)))
            } else {
                coinContent
            }
        }
        .background(
            Color(Palette.white)
                .onTapGesture {
                    focusedField = nil
                }
        )
        .onViewDidLoad {
            rootInteractor.loadAllData()
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
            TextField("Search", text: $searchText)
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
                }
                .opacity((focusedField == .search && !searchText.isEmpty) ? 1 : 0)
        }
        .background(Color(Palette.brightGray).onTapGesture {
            focusedField = .search
        })
        .cornerRadius(8, corners: .allCorners)
        .onChange(of: searchText) {
            rootInteractor.searchText = $0
        }
    }

    @ViewBuilder
    private var coinContent: some View {
        GeometryReader { proxy in
            ScrollViewReader { scrollProxy in
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                        Color.clear.frame(width: 1, height: 0)
                            .id("topEdge")
                        VStack(alignment: .leading, spacing: 0) {
                            if rootPresenter.isEmptyList {
                                noItemView
                                    .frame(minHeight: proxy.size.height, alignment: .center)
                            } else {
                                if searchText.isEmpty && !rootPresenter.topCoinList.isEmpty {
                                    topCoin
                                        .padding(.bottom, 22)
                                }
                                coinList
                            }
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 24)
                        .frame(maxWidth: 640)
                        .frameHorizontalExpand(alignment: .center)
                    }
                    .background(
                        Color(Palette.white)
                            .onTapGesture {
                                focusedField = nil
                            }
                    )
                    .onReceive(rootPresenter.$scrollToTop) { isScroll in
                        if isScroll {
                            scrollProxy.scrollTo("topEdge", anchor: .top)
                        }
                    }
                }
                .refreshable {
                    guard focusedField == nil && !rootPresenter.isLoadingList else { return }
                    searchText = ""
                    async let delay: Void? = try? await Task.sleep(seconds: 0.5)
                    async let loadData: Void = rootInteractor.resetData()
                    _ = await [delay, loadData]
                }
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
                            mainRouter.presentSheet(.init(
                                route: .coinDetail(id: item.id),
                                detent: [.fraction(0.6), .large],
                                grabber: .hidden
                            ))
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
                ForEach(rootPresenter.coinList) { item in
                    if item.hasInvite {
                        ShareLink(item: URL(string: "https://careers.lmwn.com/")!, label: {
                            Label {
                                InviteCardView()
                            } icon: {
                                EmptyView()
                            }
                        })
                    }

                    CoinCardView(
                        data: item.cardData,
                        pressAction: {
                            focusedField = nil
                            mainRouter.presentSheet(.init(
                                route: .coinDetail(id: item.id),
                                detent: [.fraction(0.6), .large],
                                grabber: .hidden
                            ))
                        }
                    )
                    .onAppear {
                        if item.id == rootPresenter.lastCoinId {
                            rootInteractor.loadMoreList()
                        }
                    }
                }
            }
            .padding(.horizontal, 8)

            if rootPresenter.isLoadingList && !rootPresenter.coinList.isEmpty && rootPresenter.errorState == .noError {
                ProgressView()
                    .frameHorizontalExpand(alignment: .center)
                    .frame(height: 60, alignment: .center)
            }

            if rootPresenter.errorState != .noError && !rootPresenter.isShowSkeleton {
                ErrorView(msg: "Could not load data", btnTitle: "Try again") {
                    rootInteractor.loadMoreList()
                }
                .disabled(rootPresenter.isLoadingList)
                .frame(height: 80)
                .frameHorizontalExpand(alignment: .center)
            }
        }
    }

    @ViewBuilder
    private var contentSkeleton: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 22) {
                // top coin
                VStack(alignment: .leading, spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(width: 120, height: 16)
                        .padding(.horizontal, 16)

                    HStack(alignment: .top, spacing: 8) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .frameHorizontalExpand(alignment: .leading)
                            .frame(height: 140)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .frameHorizontalExpand(alignment: .leading)
                            .frame(height: 140)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .frameHorizontalExpand(alignment: .leading)
                            .frame(height: 140)
                    }
                    .padding(.horizontal, 16)
                }
                .shimmering()
                .padding(.top, 16)

                // coin list
                VStack(alignment: .leading, spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(width: 160, height: 16)
                        .padding(.horizontal, 16)

                    VStack(alignment: .leading, spacing: 12) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .frame(height: 82)
                            .frameHorizontalExpand(alignment: .center)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .frame(height: 82)
                            .frameHorizontalExpand(alignment: .center)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .frame(height: 82)
                            .frameHorizontalExpand(alignment: .center)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .frame(height: 82)
                            .frameHorizontalExpand(alignment: .center)
                    }
                    .padding(.horizontal, 8)
                }
                .shimmering()
                .padding(.bottom, 24)
            }
            .frame(maxWidth: 640)
            .frameHorizontalExpand(alignment: .center)
        }
        .background(Color(Palette.white))
    }

    @ViewBuilder
    private var noItemView: some View {
        ErrorView(
            title: "Sorry",
            msg: searchText.isEmpty ? "No result" : "No result match this keyword"
        )
        .padding(.bottom, 22)
        .frameExpand()
        .background(
            Color(Palette.white)
                .onTapGesture {
                    focusedField = nil
                }
        )
    }
}

#Preview {
    RootView.view(
        presenter: RootPresenter(),
        interactor: RootInteractor()
    )
}
