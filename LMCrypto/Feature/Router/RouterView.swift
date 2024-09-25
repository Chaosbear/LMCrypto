//
//  RouterView.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @ObservedObject var router: Router
    // Our root view content
    private let content: Content

    init(
        router: Router,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._router = ObservedObject(wrappedValue: router)
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Route.self) { route in
                    router.view(for: route, type: .push)
                }
                .toolbar(.hidden, for: .navigationBar)
        }
        .sheet(item: $router.presentingSheet) { property in
            router.view(for: property.route, type: .sheet)
                .presentationDetents(property.detent)
        }
        .fullScreenCover(item: $router.presentingFullScreenCover) { route in
            router.view(for: route, type: .fullScreenCover)
        }
    }
}
