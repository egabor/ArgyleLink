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
            .subscribe(on: DispatchQueue(label: "network", qos: .utility))
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse else {
                    throw BaseApiError.urlResponseIsNil
                }

                guard 200...299 ~= response.statusCode else {
                    guard let responseString = String(
                        data: element.data,
                        encoding: .utf8
                    ) else {
                        throw BaseApiError.invalidResponseBody(element.data)
                    }
                    throw BaseApiError.invalidStatusCode(response.statusCode, responseString)
                }
                return element.data
            }
            .mapError { error -> BaseApiError in
                guard let error = error as? BaseApiError else {
                    return .other(error.localizedDescription)
                }
                return error
            }
            .decode(type: D.self, decoder: decoder)
            .eraseToAnyPublisher()
    }

    func buildRequest<D: Decodable>(
        with requestData: NetworkRequest
    ) async throws -> D {
        do {
            return try await asyncNetworkRequest(with: requestData)
        } catch let error as BaseApiError {
            throw error
        } catch let error {
            throw BaseApiError.other(error.localizedDescription)
        }
    }

    private func asyncNetworkRequest<D: Decodable>(
        with requestData: NetworkRequest
    ) async throws -> D {
        try await withCheckedThrowingContinuation { continuation in
            networkRequestPublisher(with: requestData)
                .sink(
                    receiveCompletion: { [weak self] completion in self?.handleCompletion(completion, continuation) },
                    receiveValue: { [weak self] value in self?.handleValue(value, continuation) }
                )
                .store(in: &cancellables)
        }
    }

    private func handleCompletion<D: Decodable, E: Error>(
        _ completion: Subscribers.Completion<E>,
        _ continuation: CheckedContinuation<D, E>
    ) {
        if case .failure(let error) = completion {
            continuation.resume(throwing: error)
        }
    }

    private func handleValue<D: Decodable, E: Error>(
        _ value: D,
        _ continuation: CheckedContinuation<D, E>
    ) {
        continuation.resume(returning: value)
    }
}
