//
//  CustomShape.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

struct HorizontalTicketRectangle: Shape {
    private var cornerRadius: CGFloat
    private var curveRadius: CGFloat
    private var minorWidth: CGFloat

    init(
        cornerRadius: CGFloat,
        curveRadius: CGFloat,
        minorWidth: CGFloat
    ) {
        self.cornerRadius = cornerRadius
        self.curveRadius = curveRadius
        self.minorWidth = minorWidth
    }

    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
            path.addArc(
                center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 270),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.maxX - minorWidth - (curveRadius * 2), y: rect.minY))
            path.addArc(
                center: CGPoint(x: rect.maxX - minorWidth - curveRadius, y: rect.minY),
                radius: curveRadius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 0),
                clockwise: true
            )
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 270),
                endAngle: Angle(degrees: 0),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.maxX - minorWidth, y: rect.maxY))
            path.addArc(
                center: CGPoint(x: rect.maxX - minorWidth - curveRadius, y: rect.maxY),
                radius: curveRadius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: true
            )
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
            path.addArc(
                center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        }
    }
}

struct ChampferRectangle: Shape {
    private var topLeft: CGPoint
    private var topRight: CGPoint
    private var bottomRight: CGPoint
    private var bottomLeft: CGPoint

    init(
        topLeft: CGPoint,
        topRight: CGPoint,
        bottomRight: CGPoint,
        bottomLeft: CGPoint
    ) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomRight = bottomRight
        self.bottomLeft = bottomLeft
    }

    init(
        _ radius: CGFloat,
        corners: UIRectCorner = .allCorners
    ) {
        self.topLeft = corners.contains(.topLeft) ? .init(x: radius, y: radius) : .zero
        self.topRight = corners.contains(.topRight) ? .init(x: radius, y: radius) : .zero
        self.bottomRight = corners.contains(.bottomRight) ? .init(x: radius, y: radius) : .zero
        self.bottomLeft = corners.contains(.bottomLeft) ? .init(x: radius, y: radius) : .zero
    }

    init(
        x: CGFloat,
        y: CGFloat,
        corners: UIRectCorner = .allCorners
    ) {
        self.topLeft = corners.contains(.topLeft) ? .init(x: x, y: y) : .zero
        self.topRight = corners.contains(.topRight) ? .init(x: x, y: y) : .zero
        self.bottomRight = corners.contains(.bottomRight) ? .init(x: x, y: y) : .zero
        self.bottomLeft = corners.contains(.bottomLeft) ? .init(x: x, y: y) : .zero
    }

    func path(in rect: CGRect) -> Path {
        let maxX = rect.width / 2
        let maxY = rect.height / 2

        let tLeft = CGPoint(x: min(topLeft.x, maxX), y: min(topLeft.y, maxY))
        let tRight = CGPoint(x: min(topRight.x, maxX), y: min(topRight.y, maxY))
        let bRight = CGPoint(x: min(bottomRight.x, maxX), y: min(bottomRight.y, maxY))
        let bLeft = CGPoint(x: min(bottomLeft.x, maxX), y: min(bottomLeft.y, maxY))

        return Path { path in
            path.move(to: .init(x: rect.minX + tLeft.x, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX - tRight.x, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX, y: rect.minY + tRight.y))
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY - bRight.y))
            path.addLine(to: .init(x: rect.maxX - bRight.x, y: rect.maxY))
            path.addLine(to: .init(x: rect.minX + bLeft.x, y: rect.maxY))
            path.addLine(to: .init(x: rect.minX, y: rect.maxY - bLeft.y))
            path.addLine(to: .init(x: rect.minX, y: rect.minY + tLeft.y))
            path.addLine(to: .init(x: rect.minX + tLeft.x, y: rect.minY))
        }
    }
}
