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

    /// borderPathSquare is custom drawing border line of content
    ///
    @ViewBuilder
    func borderPathSquare(_ height: CGFloat, _ width: CGFloat, _ lineWidth: CGFloat, _ radius: CGFloat, _ frame: CGSize) -> some View { self
        .overlay(
            Path { path in
                path.move(to: CGPoint(x: height, y: 0))
                path.addLine(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: width))

                path.move(to: CGPoint(x: frame.height - height, y: 0))
                path.addLine(to: CGPoint(x: frame.height, y: 0))
                path.addLine(to: CGPoint(x: frame.height, y: width))

                path.move(to: CGPoint(x: height, y: frame.width))
                path.addLine(to: CGPoint(x: 0, y: frame.width))
                path.addLine(to: CGPoint(x: 0, y: frame.width - width))

                path.move(to: CGPoint(x: frame.height - height, y: frame.width))
                path.addLine(to: CGPoint(x: frame.height, y: frame.width))
                path.addLine(to: CGPoint(x: frame.height, y: frame.width - width))
            }
            .stroke(.white, lineWidth: lineWidth)
            .cornerRadius(radius)
        )
    }

    @ViewBuilder
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    @ViewBuilder
    func cornerRadiusWithBorder<S: ShapeStyle>(
        _ content: S,
        radius: CGFloat,
        width: CGFloat,
        corners: UIRectCorner,
        inset: UIEdgeInsets = .zero
    ) -> some View { self
        .clipShape(RoundedCorner(radius: radius, corners: corners))
        .overlay(RoundedCorner(radius: radius, corners: corners, inset: inset).stroke(content, lineWidth: width))
    }

    @ViewBuilder
    func ticketBorder<S: ShapeStyle>(
        _ content: S,
        ticketMinorWidth: CGFloat,
        radius: CGFloat,
        curveRadius: CGFloat,
        borderWidth: CGFloat
    ) -> some View {
        self
            .clipShape(HorizontalTicketRectangle(
                cornerRadius: radius,
                curveRadius: curveRadius,
                minorWidth: ticketMinorWidth
            ))
            .overlay(
                HorizontalTicketRectangle(
                    cornerRadius: radius,
                    curveRadius: curveRadius,
                    minorWidth: ticketMinorWidth
                )
                .stroke(content, lineWidth: borderWidth)
            )
    }

    @ViewBuilder
    func chamferCorner(
        _ radius: CGFloat,
        corners: UIRectCorner = .allCorners
    ) -> some View {
        self
           .clipShape(ChampferRectangle(radius, corners: corners))
    }

    @ViewBuilder
    func chamferCorner(
        x: CGFloat,
        y: CGFloat,
        corners: UIRectCorner = .allCorners
    ) -> some View {
        self
            .clipShape(ChampferRectangle(x: x, y: y, corners: corners))
    }

    @ViewBuilder
    func chamferCorner(
        topLeft: CGPoint,
        topRight: CGPoint,
        bottomRight: CGPoint,
        bottomLeft: CGPoint
    ) -> some View {
        self
           .clipShape(ChampferRectangle(
            topLeft: topLeft,
            topRight: topRight,
            bottomRight: bottomRight,
            bottomLeft: bottomLeft
           ))
    }

    @ViewBuilder
    func chamferBorder<S: ShapeStyle>(
        _ content: S,
        _ radius: CGFloat,
        corners: UIRectCorner = .allCorners,
        width: CGFloat = 1
    ) -> some View {
        let shape = ChampferRectangle(radius, corners: corners)

        self
           .clipShape(shape)
           .overlay(shape.stroke(content, lineWidth: width))
    }

    @ViewBuilder
    func chamferBorder<S: ShapeStyle>(
        _ content: S,
        x: CGFloat,
        y: CGFloat,
        corners: UIRectCorner = .allCorners,
        width: CGFloat = 1
    ) -> some View {
        let shape = ChampferRectangle(x: x, y: y, corners: corners )

        self
           .clipShape(shape)
           .overlay(shape.stroke(content, lineWidth: width))
    }

    @ViewBuilder
    func chamferBorder<S: ShapeStyle>(
        _ content: S,
        topLeft: CGPoint,
        topRight: CGPoint,
        bottomRight: CGPoint,
        bottomLeft: CGPoint,
        width: CGFloat = 1
    ) -> some View {
        let shape = ChampferRectangle(
            topLeft: topLeft,
            topRight: topRight,
            bottomRight: bottomRight,
            bottomLeft: bottomLeft
        )

        self
            .clipShape(shape)
            .overlay(shape.stroke(content, lineWidth: width))
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
