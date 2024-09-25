//
//  ErrorView.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 26/9/2567 BE.
//

import SwiftUI

struct ErrorView: View {
    // MARK: - Property
    @EnvironmentObject var theme: ThemeState
    @Environment(\.isEnabled) private var isEnabled

    var title: String?
    var msg: String?
    var btnTitle: String?
    var btnAction: (() -> Void)?

    // MARK: - Text Style
    private var titleTextStyle: TextStyler { TextStyler(
        font: theme.font.h1.bold,
        color: Color(Palette.nightRiderGray)
    )}
    private var msgTextStyle: TextStyler { TextStyler(
        font: theme.font.h3.regular,
        color: Color(Palette.coolGray)
    )}
    private var btnTextStyle: TextStyler { TextStyler(
        font: theme.font.h4.bold,
        color: Color(Palette.brilliantAzure)
    )}

    // MARK: - Init
    init(
        title: String? = nil,
        msg: String? = nil,
        btnTitle: String? = nil,
        btnAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.msg = msg
        self.btnTitle = btnTitle
        self.btnAction = btnAction
    }

    // MARK: - UI Body
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if let title = title {
                Text(title)
                    .modifier(titleTextStyle)
                    .padding(.bottom, 12)
            }
            if let msg = msg {
                Text(msg)
                    .modifier(msgTextStyle)
            }
            if let btnTitle = btnTitle, let action = btnAction {
                ZStack(alignment: .center) {
                    Text(btnTitle)
                        .modifier(btnTextStyle)
                        .padding(.vertical, 4)
                        .contentShape(.rect)
                        .asButton {
                            action()
                        }
                        .opacity(isEnabled ? 1 : 0)

                    ProgressView()
                        .padding(.vertical, 4)
                        .opacity(isEnabled ? 0 : 1)
                }
            }
        }
    }
}

#Preview {
    ErrorView()
}
