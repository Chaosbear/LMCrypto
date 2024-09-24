//
//  ThemeState.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

class ThemeState: ObservableObject {
    @Published private(set) var font: FontSystemProtocol
    @Published private(set) var color: ColorSystemProtocol

    init(
        font: FontSystemProtocol,
        color: ColorSystemProtocol
    ) {
        self.font = font
        self.color = color
    }

    func setFont(_ newFont: FontSystemProtocol) {
        font = newFont
    }

    func setColor(_ newColor: ColorSystemProtocol) {
        color = newColor
    }
}
