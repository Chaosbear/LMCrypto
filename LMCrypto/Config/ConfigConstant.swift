//
//  ConfigConstant.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 25/9/2567 BE.
//

import Foundation

enum Config {
    // MARK: - Info From Config File
    static let infoDict: [String: Any] = Bundle.main.infoDictionary?["AppConfig"] as! [String: Any]

    // MARK: - Config Value
    static let useMockData = getInfoValue(key: "USE_MOCK_DATA") == "YES"
    static let enableNetFox = getInfoValue(key: "ENABLE_NETFOX") == "YES"

    static let baseUrl = getInfoValue(key: "BASE_URL")!

    // MARK: - Get Plist Value
    static func getInfoValue(key: String) -> String? {
        print("[lmwn] infoDict: \(infoDict)")
        print("[lmwn] key: \(key) -> \(String(describing: infoDict[key] as? String))")
        return infoDict[key] as? String
    }
}
