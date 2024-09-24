//
//  FontExtension.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

extension Font {
    static func scaledSystem(
        size: CGFloat,
        weight: Font.Weight = .regular,
        design: Font.Design = .default
    ) -> Font {
        return .system(
            size: UIFontMetrics.default.scaledValue(for: size),
            weight: weight,
            design: design
        )
    }
}

struct TextStyler: ViewModifier {
    enum FontType {
        case custom(
            name: String,
            size: CGFloat
        )
        case fixCustom(
            name: String,
            fixSize: CGFloat
        )
        case system(
            size: CGFloat,
            weight: Font.Weight = .regular,
            design: Font.Design = .default
        )
        case fixSystem(
            size: CGFloat,
            weight: Font.Weight = .regular,
            design: Font.Design = .default
        )
    }

    // observe text size change by
    // declaring dynamicTypeSize environment
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    private var initialFont: FontType
    private var color: Color

    private var font: Font {
        switch initialFont {
        case .custom(let name, let size):
            return .custom(name, size: size)
        case .fixCustom(let name, let fixSize):
            return .custom(name, fixedSize: fixSize)
        case .system(let size, let weight, let design):
            return .scaledSystem(
                size: size,
                weight: weight,
                design: design
            )
        case .fixSystem(let size, let weight, let design):
            return .system(
                size: size,
                weight: weight,
                design: design
            )
        }
    }

    init(
        font: FontType,
        color: Color
    ) {
        self.initialFont = font
        self.color = color
    }

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
    }
}
