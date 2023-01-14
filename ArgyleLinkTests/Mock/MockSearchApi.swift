//
//  MockSearchApi.swift
//  ArgyleLinkTests
//
//  Created by Eszenyi Gábor on 2023. 01. 14..
//

import Foundation
import Combine
@testable import ArgyleLink

class MockSearchApi: SearchApiProtocol {
    func getLinkItems(
        for searchExpression: String,
        limit: Int
    ) -> AnyPublisher<ArgyleLink.LinkItemsResponse, Error> {
        Just(
            ArgyleLink.LinkItemsResponse(
                results: [
                    .init(
                        id: "01",
                        name: "",
                        kind: .creator,
                        logoUrl: nil
                    )
                ]
            )
        )
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
