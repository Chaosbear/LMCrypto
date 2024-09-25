//
//  ColorDesignSystem.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

protocol ColorSystemProtocol {
    var primary: Color { get }
    var primary2: Color { get }
    var secondary: Color { get }
    var secondary2: Color { get }
    var neutral: Color { get }
    var background: Color { get }
    var surface: Color { get }
    var surfaceOn: Color { get }
    var shadow: Color { get }

    var success: Color { get }
    var warning: Color { get }
    var error: Color { get }

    var h1: Color { get }
    var h2: Color { get }
    var h3: Color { get }
    var h4: Color { get }
    var h5: Color { get }
    var body1: Color { get }
    var body2: Color { get }
    var caption: Color { get }
    var overline: Color { get }
}

struct DefaultColorTheme: ColorSystemProtocol {
    var primary = Color(Palette.nightRiderGray)
    var primary2 = Color(Palette.nightRiderGray)
    var secondary = Color(Palette.nightRiderGray)
    var secondary2 = Color(Palette.nightRiderGray)
    var neutral = Color(Palette.nightRiderGray)
    var background = Color(light: Palette.nightRiderGray, night: Palette.nightRiderGray)
    var surface = Color(Palette.ghostWhite)
    var surfaceOn = Color(Palette.nightRiderGray)
    var success = Color(Palette.nightRiderGray)
    var warning = Color(Palette.nightRiderGray)
    var error = Color(Palette.nightRiderGray)
    var shadow = Color(Palette.black)

    var h1 = Color(light: Palette.nightRiderGray, night: Palette.nightRiderGray)
    var h2 = Color(light: Palette.nightRiderGray, night: Palette.nightRiderGray)
    var h3 = Color(light: Palette.nightRiderGray, night: Palette.nightRiderGray)
    var h4 = Color(light: Palette.nightRiderGray, night: Palette.nightRiderGray)
    var h5 = Color(light: Palette.nightRiderGray, night: Palette.nightRiderGray)
    var body1 = Color(light: Palette.nightRiderGray, night: Palette.nightRiderGray)
    var body2 = Color(light: Palette.nightRiderGray, night: Palette.nightRiderGray)
    var caption = Color(Palette.nightRiderGray)
    var overline = Color(Palette.nightRiderGray)
}
