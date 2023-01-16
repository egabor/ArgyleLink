//
//  BaseApi.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 11..
//

import Foundation
import Combine
import Resolver

class BaseApi {

    @Injected private var decoder: JSONDecoder
    var headers: [String: String] = [:]
    var cancellables = Set<AnyCancellable>()

    private static let networkQueue = DispatchQueue(label: "network", qos: .utility)
    let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func networkRequestPublisher<D: Decodable>(
        with requestData: NetworkRequest
    ) -> AnyPublisher<D, Error> {
        guard let urlRequest = try? requestData.asURLRequest() else {
            return Fail(error: BaseApiError.urlRequestIsNil)
                .eraseToAnyPublisher()
        }
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .subscribe(on: BaseApi.networkQueue)
            .tryMap { [weak self] element -> Data in
                guard let response = element.response as? HTTPURLResponse else {
                    throw BaseApiError.urlResponseIsNil
                }

                guard 200...299 ~= response.statusCode else {
                    guard let errorResponse = try? self?.decoder.decode(ErrorResponse.self, from: element.data) else {
                        throw BaseApiError.invalidStatusCode(response.statusCode)
                    }
                    throw BaseApiError.decoded(errorResponse)
                }
                return element.data
            }
            .decode(type: D.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
