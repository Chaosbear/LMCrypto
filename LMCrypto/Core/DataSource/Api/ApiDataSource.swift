//
//  ApiDataSource.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 25/9/2567 BE.
//

import Foundation

class ApiDataSource {
    // MARK: - Properties
    static let shared = ApiDataSource()
    public let manager = ApiManager.shared

    func defaultParameters() -> [String: Any] {
        return [String: Any]()
    }
}
