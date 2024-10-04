//
//  BorderCornerExtension.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

extension View {
    /// Original SwiftUI's `.cornerRadius` and `.border` don't concern each other. This function fill this gap.
    ///
    @ViewBuilder
    func border<S: ShapeStyle>(_ content: S, cornerRadius: CGFloat, width: CGFloat, inset: CGFloat = 0) -> some View { self
        .mask(Rectangle().cornerRadius(cornerRadius))
        .overlay(RoundedRectangle(cornerRadius: cornerRadius).inset(by: inset).stroke(content, lineWidth: width))
    }

    @ViewBuilder
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

/// Round specific corner link
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    var inset: UIEdgeInsets = .zero

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect.inset(by: inset), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
