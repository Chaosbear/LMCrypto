//
//  PaginationModel.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 25/9/2567 BE.
//

import Foundation

struct PaginationModel {
    var loadedPage: Int
    let limit: Int
    var hasNext: Bool

    init(
        loadedPage: Int = 0,
        limit: Int = 10,
        hasNext: Bool = true
    ) {
        self.loadedPage = loadedPage
        self.limit = limit
        self.hasNext = hasNext
    }

    var offset: Int {
        loadedPage * limit
    }
}
