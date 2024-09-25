//
//  ApiBaseModel.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation

struct ApiBaseModel<T: Codable> {
    var status: String
    var code: String?
    var message: String?
    var data: T?

    init(
        status: String = "",
        code: String = "",
        message: String = "",
        data: T? = nil
    ) {
        self.status = status
        self.code = code
        self.message = message
        self.data = data
    }
}

extension ApiBaseModel: Codable {

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)

        do {
            self.status = try map.decodeIfPresent(String.self, forKey: .status) ?? ""
            self.code = try map.decodeIfPresent(String.self, forKey: .code) ?? nil
            self.message = try map.decodeIfPresent(String.self, forKey: .message) ?? nil
            self.data = try map.decodeIfPresent(T.self, forKey: .data) ?? nil
        } catch {
            self = Self()
        }
    }
}

struct ApiResponseStatusModel {
    let isSuccess: Bool
    let error: Error?
    let statusCode: Int

    init(
        _ isSuccess: Bool = true,
        _ error: Error? = nil,
        _ statusCode: Int = 0
    ) {
        self.isSuccess = isSuccess
        self.error = error
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
