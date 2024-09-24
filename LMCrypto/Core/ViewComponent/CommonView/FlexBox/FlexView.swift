//
//  FlexView.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import SwiftUI

/// Ref: https://www.fivestars.blog/articles/flexible-swiftui/
/// Facade of our view, its main responsibility is to get the available width
/// and pass it down to the real implementation, `FlexViewLayout`.
struct FlexView<Data: Swift.Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    // The initial width should not be `0`, otherwise all items will be layouted in one row,
    // and the actual layout width may exceed the value we desired.
    @State var availableWidth: CGFloat = 10

    var body: some View {
        FlexViewLayout(
            availableWidth: availableWidth,
            data: data,
            spacing: spacing,
            alignment: alignment,
            content: content
        )
        .frameHorizontalExpand(alignment: alignment)
        .readSize { size in
            DispatchQueue.main.async {
                availableWidth = size.width
            }
        }
    }
}

/// This view is responsible to lay down the given elements and wrap them into
/// multiple rows if needed.
private struct FlexViewLayout<Data: Swift.Collection, Content: View>: View where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State var elementsSize: [Data.Element: CGSize] = [:]

    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
                    }
                }
            }
        }
    }

    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth

        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow += 1
                rows.append([element])
                remainingWidth = availableWidth
            }

            remainingWidth = max(0, remainingWidth - (elementSize.width + spacing))
        }

        return rows
    }
}
