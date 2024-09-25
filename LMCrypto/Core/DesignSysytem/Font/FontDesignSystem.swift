//
//  DesignSystem.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation

struct DSFontWeight {
    var light: TextStyler.FontType
    var regular: TextStyler.FontType
    var bold: TextStyler.FontType
}

protocol FontSystemProtocol {
    var h1: DSFontWeight { get }
    var h2: DSFontWeight { get }
    var h3: DSFontWeight { get }
    var h4: DSFontWeight { get }
    var h5: DSFontWeight { get }
    var body1: DSFontWeight { get }
    var body2: DSFontWeight { get }
    var caption: DSFontWeight { get }
}

struct DefaultFontTheme: FontSystemProtocol {
    var h1 = DSFontWeight(
        light: .system(size: 20, weight: .light),
        regular: .system(size: 20, weight: .regular),
        bold: .system(size: 20, weight: .bold)
    )
    var h2 = DSFontWeight(
        light: .system(size: 18, weight: .light),
        regular: .system(size: 18, weight: .regular),
        bold: .system(size: 18, weight: .bold)
    )
    var h3 = DSFontWeight(
        light: .system(size: 16, weight: .light),
        regular: .system(size: 16, weight: .regular),
        bold: .system(size: 16, weight: .bold)
    )
    var h4 = DSFontWeight(
        light: .system(size: 14, weight: .light),
        regular: .system(size: 14, weight: .regular),
        bold: .system(size: 14, weight: .bold)
    )
    var h5 = DSFontWeight(
        light: .system(size: 12, weight: .light),
        regular: .system(size: 12, weight: .regular),
        bold: .system(size: 12, weight: .bold)
    )
    var body1 = DSFontWeight(
        light: .system(size: 16, weight: .light),
        regular: .system(size: 16, weight: .regular),
        bold: .system(size: 16, weight: .bold)
    )
    var body2 = DSFontWeight(
        light: .system(size: 14, weight: .light),
        regular: .system(size: 14, weight: .regular),
        bold: .system(size: 14, weight: .bold)
    )
    var caption = DSFontWeight(
        light: .system(size: 14, weight: .light),
        regular: .system(size: 14, weight: .regular),
        bold: .system(size: 14, weight: .bold)
    )
}
