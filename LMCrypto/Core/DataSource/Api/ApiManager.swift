//
//  ApiManager.swift
//  LMCrypto
//
//  Created by Sukrit Chatmeeboon on 24/9/2567 BE.
//

import Foundation
import Alamofire
import netfox

// MARK: - Type
enum ApiVersion {
    case v2
    case custom(version: String)

    var path: String {
        switch self {
        case .v2: return "/v2"
        case .custom(let version): return version
        }
    }
}

// MARK: - Api Manager
class ApiManager {
    static let shared = ApiManager()

    private var session: Session

    init(session: Session = Session.default) {
        #if DEBUG
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses?.insert(NFXProtocol.self, at: 0)
        let nfxSession = Session(configuration: configuration)
        self.session = nfxSession
        #else
        if Config.enableNetFox {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses?.insert(NFXProtocol.self, at: 0)
            let nfxSession = Session(configuration: configuration)
            self.session = nfxSession
        } else {
            self.session = session
        }
        #endif
    }

    typealias CompletionDataResponse = (AFDataResponse<Any>) -> Void
    @discardableResult
    func apiRequest(
        _ method: HTTPMethod,
        endpoint: String = Config.baseUrl,
        apiVersion: ApiVersion = .v2,
        path: String,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: [String: String] = [:],
        retryable: Bool = false,
        timeout: Double = 60
    ) -> DataRequest {
        guard var urlComponents = URLComponents(string: endpoint + apiVersion.path + path) else { fatalError() }

        return session.request(
            urlComponents,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: .init(headers),
            interceptor: retryable ? LMCRequestInterceptor() : nil
        ) {
            $0.timeoutInterval = timeout
        }
    }
}

// MARK: - Response Handler
extension DataRequest {

    typealias CompletionDataResponse = (AFDataResponse<Any>) -> Void

    func responseDecodableHandler<T: Decodable>(
        of type: T.Type,
        decoder: DataDecoder = JSONDecoder.iso8601(),
        completion: @escaping (DataResponse<T, AFError>) -> Void
    ) {
        responseDecodable(of: type, decoder: decoder) {
            completion($0)
        }
    }

    func responseDecodableHandler<T: Decodable, E: Codable>(
        of type: T.Type,
        err errType: E.Type,
        decoder: DataDecoder = JSONDecoder.iso8601(),
        completion: @escaping (T?, E?, ApiResponseStatusModel) -> Void
    ) {
        responseDecodable(of: type, decoder: decoder) { dataResponse in
            if let response = dataResponse.response {
                switch dataResponse.result {
                case .success(let value):
                    let response = ApiResponseStatusModel(true, nil, response.statusCode)
                    completion(value, nil, response)
                case .failure(let error):
                    let response = ApiResponseStatusModel(false, error, response.statusCode)

                    var errModel: E?
                    if let errData = dataResponse.data {
                        errModel = Utils.dataToCodable(
                            data: errData,
                            type: E.self,
                            decoder: decoder as? JSONDecoder ?? JSONDecoder.iso8601()
                        )
                    }
                    completion(nil, errModel, response)
                }
            } else {
                let response = ApiResponseStatusModel(false, nil, 0)
                completion(nil, nil, response)
            }
        }
    }

    func serializingDecodableHandler<T: Decodable>(
        of type: T.Type,
        decoder: DataDecoder = JSONDecoder.iso8601()
    ) async -> (DataResponse<T, AFError>) {
        let dataResponse = await serializingDecodable(type, decoder: decoder).response
        return dataResponse
    }

    func serializingDecodableHandler<T: Decodable, E: Codable>(
        of type: T.Type,
        err errType: E.Type,
        decoder: DataDecoder = JSONDecoder.iso8601()
    ) async -> (T?, E?, ApiResponseStatusModel) {
        let dataResponse = await serializingDecodable(type, decoder: decoder).response

        if let response = dataResponse.response {
            switch dataResponse.result {
            case .success(let value):
                let response = ApiResponseStatusModel(true, nil, response.statusCode)
                return (value, nil, response)
            case .failure(let error):
                let response = ApiResponseStatusModel(false, error, response.statusCode)

                var errModel: E?
                if let errData = dataResponse.data {
                    errModel = Utils.dataToCodable(
                        data: errData,
                        type: E.self,
                        decoder: decoder as? JSONDecoder ?? JSONDecoder.iso8601()
                    )
                }
                return (nil, errModel, response)
            }
        } else {
            let response = ApiResponseStatusModel(false, nil, 0)
            return (nil, nil, response)
        }
    }
}

// MARK: - RequestInterceptor
class LMCRequestInterceptor: RequestInterceptor {
    let retryLimit = 3
    let retryDelay: TimeInterval = 1
    let retryableHTTPMethods: [HTTPMethod] = [.get]
    let retryableStatusCode: [Int] = [401]

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if request.retryCount < retryLimit,
           shouldRetry(request: request, error: error) {
            completion(.retryWithDelay(retryDelay))
        } else {
            completion(.doNotRetry)
        }
    }

    private func shouldRetry(request: Request, error: Error) -> Bool {
        guard let httpMethod = request.request?.method,
              let statusCode = request.response?.statusCode,
              retryableHTTPMethods.contains(httpMethod),
              retryableStatusCode.contains(statusCode)
        else { return false }
        return true
    }
}
