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
    var h6: Color { get }
    var subTitle1: Color { get }
    var subTitle2: Color { get }
    var body1: Color { get }
    var body2: Color { get }
    var button: Color { get }
    var caption: Color { get }
    var overline: Color { get }
}

struct DefaultColorTheme: ColorSystemProtocol {
    var primary = Color(Palette.brilliantAzure)
    var primary2 = Color(Palette.mediumAquamarine)
    var secondary = Color(Palette.cyan)
    var secondary2 = Color(Palette.brightLavender)
    var neutral = Color(Palette.nightRiderGray)
    var background = Color(light: Palette.milkWhite, night: Palette.blackPearl)
    var surface = Color(Palette.brightGray)
    var surfaceOn = Color(Palette.lavenderMist)
    var success = Color(Palette.tealishGreen)
    var warning = Color(Palette.goldenGlow)
    var error = Color(Palette.carminePink)
    var shadow = Color(Palette.gainboroGray)

    var h1 = Color(light: Palette.nightRiderGray, night: Palette.whiteSmoke)
    var h2 = Color(light: Palette.nightRiderGray, night: Palette.whiteSmoke)
    var h3 = Color(light: Palette.nightRiderGray, night: Palette.whiteSmoke)
    var h4 = Color(light: Palette.dimGray, night: Palette.gainboroGray)
    var h5 = Color(light: Palette.dimGray, night: Palette.gainboroGray)
    var h6 = Color(light: Palette.dimGray, night: Palette.gainboroGray)
    var subTitle1 = Color(light: Palette.nightRiderGray, night: Palette.whiteSmoke)
    var subTitle2 = Color(light: Palette.dimGray, night: Palette.gainboroGray)
    var body1 = Color(light: Palette.nightRiderGray, night: Palette.whiteSmoke)
    var body2 = Color(light: Palette.dimGray, night: Palette.gainboroGray)
    var button = Color(Palette.white)
    var caption = Color(Palette.darkGray)
    var overline = Color(Palette.brilliantAzure)
}
