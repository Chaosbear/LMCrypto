//
//  SeeMoreText.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

struct SeeMoreTextView: View {
    // MARK: - Properties
    private let text: String
    private let seeMoreText: String

    private let lineLimit: Int?
    private let lineSpacing: CGFloat
    private let alignment: TextAlignment

    @State private var intrinsicSize: CGSize = .zero
    @State private var truncatedSize: CGSize = .zero

    // MARK: - Life Cycle
    init(
        text: String,
        seeMoreText: String = "อ่านเพิ่มเติม",
        lineLimit: Int?,
        lineSpacing: CGFloat = 4,
        alignment: TextAlignment = .leading
    ) {
        self.text = text
        self.seeMoreText = seeMoreText
        self.lineLimit = lineLimit
        self.lineSpacing = lineSpacing
        self.alignment = alignment
    }

    // MARK: UI Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(text)
                .lineLimit(lineLimit)
                .lineSpacing(lineSpacing)
                .multilineTextAlignment(alignment)
                .truncationMode(.tail)
                .readSize { size in
                    if truncatedSize != size {
                        truncatedSize = size
                    }
                }
                .background(
                    Text("\(text)")
                        .lineLimit(lineLimit == nil ? nil : ((lineLimit ?? 5) + 5))
                        .lineSpacing(lineSpacing)
                        .multilineTextAlignment(alignment)
                        .fixedSize(horizontal: false, vertical: true)
                        .hidden()
                        .readSize { size in
                            if intrinsicSize != size {
                                intrinsicSize = size
                            }
                        }
                        .clipped()
                )
            if intrinsicSize.height > truncatedSize.height {
                Text(seeMoreText)
                    .foregroundColor(Color.orange)
                    .multilineTextAlignment(alignment)
                    .padding(.top, lineSpacing)
            }
        }
    }
}
