//
//  ApiBaseModel.swift
//  dev-ex-ios
//
//  Created by Sukrit Chatmeeboon on 8/9/2567 BE.
//

import Foundation

struct ApiBaseModel<T: Codable> {
    var code: Int
    var data: T?
    var isSuccess: Bool
    var message: String?

    init(
        code: Int = 0,
        data: T? = nil,
        isSuccess: Bool = false,
        message: String? = nil
    ) {
        self.code = code
        self.data = data
        self.isSuccess = isSuccess
        self.message = message
    }
}

extension ApiBaseModel: Codable {

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case data = "data"
        case isSuccess = "isSuccess"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.code = try map.decodeIfPresent(Int.self, forKey: .code) ?? 0
            self.data = try map.decodeIfPresent(T.self, forKey: .data) ?? nil
            self.isSuccess = try map.decodeIfPresent(Bool.self, forKey: .isSuccess) ?? false
            self.message = try map.decodeIfPresent(String?.self, forKey: .message) ?? nil
        } catch {
            self = Self()
        }
    }
}

struct ApiResponseStatusModel {
    let isSuccess: Bool
    let message: String?
    let statusCode: Int

    init(
        _ isSuccess: Bool = true,
        _ message: String? = nil,
        _ statusCode: Int = 0
    ) {
        self.isSuccess = isSuccess
        self.message = message
        self.statusCode = statusCode
    }
}

enum ApiErrorState {
    case noInternetError
    case systemError
    case invalidAuthError
    case noError

    static func defaultErrorHandler(_ responses: [ApiResponseStatusModel]) -> ApiErrorState {
        if responses.allSatisfy({ $0.isSuccess }) {
            return .noError
        } else if !responses.allSatisfy({ $0.statusCode != 401 }) {
            return .invalidAuthError
        } else {
            return NWMonitor.shared.isConnected ? .systemError : .noInternetError
        }
    }
}
