//
//  ScreenSectionItemModel.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 9/9/2567 BE.
//

import Foundation

struct ScreenSectionItemModel {
    var type: ScreenSectionType
    var presenter: AnyObject?
    var interactor: AnyObject?

    init(
        type: ScreenSectionType,
        presenter: AnyObject? = nil,
        interactor: AnyObject? = nil
    ) {
        self.type = type
        self.presenter = presenter
        self.interactor = interactor
    }
}
