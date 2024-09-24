//
//  ImagePlaceHodlerView.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 13/9/2567 BE.
//

import SwiftUI

struct AltImageView: View {
    private var image: String
    private var ratio: CGFloat
    private var maxWidth: CGFloat?

    init(
        image: String = "photo",
        ratio: CGFloat = 0.6,
        maxWidth: CGFloat? = nil
    ) {
        self.image = image
        self.ratio = ratio
        self.maxWidth = maxWidth
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                Color(Palette.darkGray)

                let idealWidth = min(proxy.size.width, proxy.size.height) * ratio
                let actualWidth = if let max = maxWidth {
                    min(idealWidth, max)
                } else {
                    idealWidth
                }
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundStyle(Color(Palette.white))
                    .frame(width: actualWidth)
            }
        }
    }
}

struct LoadImageView: View {
    var body: some View {
        Color(Palette.darkGray)
            .shimmering(bandSize: 0.6)
    }
}

#Preview {
    VStack(alignment: .center, spacing: 20) {
        AltImageView()
            .frame(width: 80, height: 80)

        LoadImageView()
            .frame(width: 80, height: 80)
    }
}
