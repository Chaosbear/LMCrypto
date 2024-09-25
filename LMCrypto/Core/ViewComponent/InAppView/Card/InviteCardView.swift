//
//  InviteCardView.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 25/9/2567 BE.
//

import SwiftUI

struct InviteCardView: View {
    // MARK: - Property
    @EnvironmentObject var theme: ThemeState

    // MARK: - Text Style
    private var detailTextStyle: TextStyler { TextStyler(
        font: theme.font.h3.regular,
        color: Color(Palette.black)
    )}
    private var inviteTextStyle: TextStyler { TextStyler(
        font: theme.font.h3.bold,
        color: Color(Palette.brilliantAzure)
    )}

    // MARK: - UI Body
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            icon
            Text("You can earn $10  when you invite a friend to buy crypto.")
                .font(detailTextStyle.font)
                .foregroundColor(detailTextStyle.color)
            + Text(" Invite your friend")
                .font(inviteTextStyle.font)
                .foregroundColor(inviteTextStyle.color)
        }
        .multilineTextAlignment(.leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .frameHorizontalExpand(alignment: .leading)
        .background(Color(Palette.hawkesBlue))
        .cornerRadius(8, corners: .allCorners)
        .contentShape(.rect)
    }

    // MARK: - UI Component
    @ViewBuilder
    private var icon: some View {
        Image("icon_gift")
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
            .frame(width: 40, height: 40)
            .background(Color(Palette.ghostWhite))
            .clipShape(.circle)
    }
}
