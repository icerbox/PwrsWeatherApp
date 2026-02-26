//
//  NetworkService.swift
//  PwrsWeatherApp
//
//  Created by Aysen Eremeev on 25.02.2026.
//

import Alamofire
import Foundation

final class NetworkService {

    func get<T: Decodable>(_ url: String, model: T.Type, completion: @escaping (RequestResult<T>) -> Void) {
        request(url, method: .get, model: model, completion: completion)
    }
}

extension NetworkService {

    private func request<T: Decodable & Sendable>(_ url: String, method: HTTPMethod, model: T.Type, completion: @escaping (RequestResult<T>) -> Void) {
        let sessionManager = getSessionManager()

        sessionManager.request(url, method: method, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(model):
                    completion(.success(model))
                case let .failure(error):
                    if let errorCode = (error.underlyingError) as? URLError, errorCode.code == .cancelled {
                        return
                    }
                    completion(.failure(error.localizedDescription))
            }
        }
    }

    private func getSessionManager() -> Session {
        return NetworkSession.manager
    }
}
