//
//  CoinListItemModel.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 25/9/2567 BE.
//

import Foundation

struct CoinListItemModel: Identifiable {
    let id: String
    let model: CoinModel
    let cardData: CoinCardData
    let hasInvite: Bool

    init(model: CoinModel, hasInvite: Bool) {
        self.id = model.uuid
        self.model = model
        self.cardData = CoinCardData(model: model)
        self.hasInvite = hasInvite
    }
}
