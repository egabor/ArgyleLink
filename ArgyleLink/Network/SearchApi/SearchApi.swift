//
//  SearchApi.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 11..
//

import Foundation
import Resolver
import Combine

class SearchApi: BaseApi, SearchApiProtocol {

    @Injected private var authorizationHeaderValue: BasicAuthorizationValueUseCaseProtocol

    func getLinkItems(for searchExpression: String, limit: Int) -> AnyPublisher<LinkItemsResponse, Error> {
        networkRequestPublisher(with: getLinkItemsRequest(for: searchExpression, limit: limit))
    }

    private func getLinkItemsRequest(for searchExpression: String, limit: Int) -> NetworkRequest {
        var customHeaders = headers
        customHeaders[.httpHeaderKeyAuthorization] = authorizationHeaderValue(
            username: Configuration.apiKey.value,
            password: Configuration.apiSecret.value
        )
        let queryItems: [URLQueryItem] = [
            .init(name: "q", value: searchExpression),
            .init(name: "limit", value: String(limit))
        ]

        return NetworkRequest(baseUrl, "v1/search/link-items", .get, customHeaders, queryItems: queryItems)
    }
}
