//
//  ViewExtension.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

typealias ViewModifierClosure<T: View> = (AnyView) -> T

extension View {
    /// [modifier(_:)]: doc://com.apple.documentation/documentation/swiftui/view/modifier(_:)
    /// [ViewModifier]: doc://com.apple.documentation/documentation/swiftui/viewmodifier
    ///
    /// A function overload of SwiftUI's [modifier(_:)] that uses a closure instead of [ViewModifier].
    ///
    func modifier<T: View>(_ modifier: @escaping ViewModifierClosure<T>) -> some View {
        self.modifier(ClosureViewModifierAdapter(modifier: modifier))
    }
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}

private struct ClosureViewModifierAdapter<Body: View>: ViewModifier {
    var modifier: ViewModifierClosure<Body>
    func body(content: Content) -> Body { modifier(AnyView(content)) }
}

private struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

extension View {
    // MARK: - Convenience functions for layouts

    func frame(_ size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }

    func frameHorizontalExpand(alignment: HorizontalAlignment? = .center) -> some View {
        frame(
            maxWidth: alignment.flatMap { _ in .infinity },
            alignment: Alignment(horizontal: alignment ?? .center, vertical: .center)
        )
    }

    func frameVerticalExpand(alignment: VerticalAlignment? = .center) -> some View {
        frame(
            maxHeight: alignment.flatMap { _ in .infinity },
            alignment: Alignment(horizontal: .center, vertical: alignment ?? .center)
        )
    }

    func frameExpand(alignment: Alignment? = .center) -> some View {
        frame(maxWidth: alignment.flatMap { _ in .infinity }, maxHeight: .infinity, alignment: alignment ?? .center)
    }

    func aspectClipped(_ ratio: CGFloat? = nil, contentMode: ContentMode) -> some View {
        Color.clear
            .aspectRatio(ratio, contentMode: .fit)
            .overlay(alignment: .center) {
                self.aspectRatio(contentMode: contentMode)
            }
            .clipped()
    }

    func padding(css top: CGFloat, _ trailing: CGFloat, _ bottom: CGFloat, _ leading: CGFloat
    ) -> some View { self
        .padding(EdgeInsets(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing
        ))
    }

    // MARK: - Misc
    func asButton(action: @escaping () -> Void) -> some View {
        Button(action: action) { self }
    }
}
