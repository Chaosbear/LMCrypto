//
//  ToastView.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

struct ToastModifier<ToastView: View>: ViewModifier {
    @Binding var isPresenting: Bool
    var duration: Double
    var alignment: Alignment
    var toastPadding: EdgeInsets
    var toastView: () -> ToastView

    init(
        isPresenting: Binding<Bool>,
        duration: Double,
        alignment: Alignment,
        padding: EdgeInsets,
        toastView: @escaping () -> ToastView
    ) {
        self._isPresenting = isPresenting
        self.duration = duration
        self.alignment = alignment
        self.toastPadding = padding
        self.toastView = toastView
    }

    func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                if isPresenting {
                    toastView()
                        .padding(toastPadding)
                        .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                } else {
                    EmptyView()
                }
            }
            .onChange(of: isPresenting) { isPresent in
                if isPresent {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        if isPresenting {
                            isPresenting = false
                        }
                    }
                }
            }
    }
}

struct ToastView: View {
    private var msg: String
    private var image: String?
    private var maxWidth: CGFloat?

    private let isPhone = UIDevice.current.userInterfaceIdiom == .phone

    private let msgTextStyle = TextStyler(
        font: .system(size: UIDevice.current.userInterfaceIdiom == .phone ? 14 : 16),
        color: Color.white
    )

    init(
        msg: String,
        image: String?,
        maxWidth: CGFloat?
    ) {
        self.msg = msg
        self.image = image
        self.maxWidth = maxWidth
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if let icon = image {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: isPhone ? 14 : 16, height: isPhone ? 14 : 16)
                    .foregroundStyle(Color.orange)
            }
            Text(msg)
                .modifier(msgTextStyle)
                .multilineTextAlignment(.leading)
                .frameHorizontalExpand(alignment: .leading)
        }
        .frame(maxWidth: maxWidth)
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(Color.black.opacity(0.6))
        .background(.ultraThinMaterial)
        .cornerRadius(8, corners: .allCorners)
        .compositingGroup()
    }
}
