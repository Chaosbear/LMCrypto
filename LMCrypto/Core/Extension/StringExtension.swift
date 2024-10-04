//
//  StringExtension.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation
import CryptoKit

extension String {
    func encodeUrl() -> String? {
        if let decomposedString = self.removingPercentEncoding, decomposedString != self {
            return self
        } else {
            return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
    }

    func encodedUrl() -> URL? {
        return encodeUrl().map { URL(string: $0)} ?? nil
    }
}
