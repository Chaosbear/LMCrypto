//
//  DoubleExtension.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 26/9/2567 BE.
//

extension Double {
    var isInteger: Bool {
        return self.truncatingRemainder(dividingBy: 1) == 0
    }
}
