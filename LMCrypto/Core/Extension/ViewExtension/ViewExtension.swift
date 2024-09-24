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
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func onSwipeRightDismissNavigationDestination(action: @escaping () -> Void) -> some View {
        self.gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 200 {
                        withAnimation {
                            action()
                        }
                    }
                }
        )
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

    func fixedSize(_ axis: Axis.Set) -> some View { self
        .fixedSize(horizontal: axis.contains(.horizontal), vertical: axis.contains(.vertical))
    }

    func positionIn(space: UUID, handler: @escaping (CGPoint) -> Void) -> some View {
        PositionObservingView(
            coordinateSpace: .named(space),
            handler: handler,
            content: { self }
        )
    }

    // MARK: - Misc

    func asButton(action: @escaping () -> Void) -> some View {
        Button(action: action) { self }
    }

    func asScrollView(_ axes: Axis.Set, showIndicators: Bool) -> some View {
        ScrollView(axes, showsIndicators: showIndicators) { self }
    }

    func redacted(_ isRedacted: Bool = true) -> some View {
        redacted(reason: isRedacted ? .placeholder : [])
    }

    func redactAndDisable(_ disabled: Bool) -> some View { self
        .redacted(reason: disabled ? .placeholder : [])
        .disabled(disabled)
    }

    @ViewBuilder
    func hiddenListRowSeparator() -> some View {
        if #available(iOS 15.0, *) {
            self.listRowSeparator(.hidden)
        } else {
            self
        }
    }

    @ViewBuilder
    func scrollContentBackgroundIfAvaliable(_ visibility: Visibility = .hidden) -> some View {
        if #available(iOS 16.0, *) {
            self.scrollContentBackground(visibility)
        } else {
            self
        }
    }

    func clearListRowBackgroundAndInset() -> some View {
        self.listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
    }

    func toast(
        isPresenting: Binding<Bool>,
        msg: String,
        image: String? = nil,
        duration: Double = 1.5,
        alignment: Alignment = .bottom,
        padding: EdgeInsets = .init(top: 8, leading: 16, bottom: 24, trailing: 16),
        maxWidth: CGFloat?
    ) -> some View {
        self.modifier(
            ToastModifier(
                isPresenting: isPresenting,
                duration: duration,
                alignment: alignment,
                padding: padding
            ) {
                ToastView(
                    msg: msg,
                    image: image,
                    maxWidth: maxWidth
                )
            }
        )
    }

    func onAppResignActive(_ action: @escaping () -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
            perform: { _ in action() }
        )
    }

    func onAppActive(_ action: @escaping () -> Void) -> some View {
        self.onReceive(
            NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification),
            perform: { _ in action() }
        )
    }
}

/// A color fill that has the exact same color with `Text(…).foregroundColor(Color(.label)).redacted(…)`.
///
struct RedactionRectangle: View {
    var contentColor: Color = Color(.label)
    var body: some View { anyRedactionFill }
    private var anyRedactionFill: some View { Image(systemName: "xmark")
            .resizable()
            .foregroundColor(contentColor)
            .redacted(reason: .placeholder)
    }
}

/// For applying complex visual effect likes frosted glass (UIBlurEffect) on top other views in SwiftUI using
/// UIVisualEffectView.
///
/// Check UIVisualEffectView documentation.
///
struct UiVisualEffectViewAdapter: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        view.effect = effect
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {

    }
}

struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    var handler: (CGPoint) -> Void
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: PositionObservingPreferenceKey.self,
                            value: geometry.frame(in: coordinateSpace).origin
                        )
                }
            )
            .onPreferenceChange(PositionObservingPreferenceKey.self) { position in
                handler(position)
            }
    }
}

private extension PositionObservingView {
    struct PositionObservingPreferenceKey: PreferenceKey {
        static var defaultValue: CGPoint { .zero }

        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
    }
}

extension View {
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition { transform(self) } else { self }
    }

    @ViewBuilder
    func `if`<IfTransform: View, ElseTransform: View>(
        _ condition: Bool,
        if ifTransform: (Self) -> IfTransform,
        else elseTransform: (Self) -> ElseTransform
    ) -> some View {
        if condition { ifTransform(self) } else { elseTransform(self) }
    }

    @ViewBuilder
    func ifLet<T, Transform: View>(
        _ value: T?,
        transform: (Self, T) -> Transform
    ) -> some View {
        if let value = value { transform(self, value) } else { self }
    }

    @ViewBuilder
    func ifLet<T, IfTransform: View, ElseTransform: View>(
        _ value: T?,
        if ifTransform: (Self, T) -> IfTransform,
        else elseTransform: (Self) -> ElseTransform
    ) -> some View {
        if let value = value { ifTransform(self, value) } else { elseTransform(self) }
    }
}

private struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func readFrame(onChange: @escaping (CGRect) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: FramePreferenceKey.self, value: geometryProxy.frame(in: .global))
            }
        )
        .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }

    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}
