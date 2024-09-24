//
//  DateExtension.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation

extension Date {
    func toDateComponent(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func toDateComponent(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
