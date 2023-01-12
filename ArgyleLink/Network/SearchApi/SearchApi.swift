//
//  SearchApi.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 11..
//

import Foundation
import Resolver

class SearchApi: BaseApi, SearchApiProtocol {

    @Injected private var authorizationHeaderValue: BasicAuthorizationValueUseCaseProtocol

    func getLinkItems(for searchExpression: String, limit: Int) async throws -> LinkItemsResponse {
        var customHeaders = headers
        customHeaders[.httpHeaderKeyAuthorization] = authorizationHeaderValue(
            username: Configuration.apiKey.value,
            password: Configuration.apiSecret.value
        )
        let queryItems: [URLQueryItem] = [
            .init(name: "q", value: searchExpression),
            .init(name: "limit", value: String(limit))
        ]

        let request = NetworkRequest(baseUrl, "v1/search/link-items", .get, customHeaders, queryItems: queryItems)
        return try await buildRequest(with: request)
    }
}
