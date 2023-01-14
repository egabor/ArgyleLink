//
//  MockSearchApi.swift
//  ArgyleLinkTests
//
//  Created by Eszenyi Gábor on 2023. 01. 14..
//

import Foundation
import Combine
import Resolver
@testable import ArgyleLink

class MockSearchApi: SearchApiProtocol {

    var mockResult: MockSearchResult?

    @Injected private var decoder: JSONDecoder

    func getLinkItems(
        for searchExpression: String,
        limit: Int
    ) -> AnyPublisher<LinkItemsResponse, Error> {
        Future<LinkItemsResponse, Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(MockError.unknown))
                return
            }

            guard let fileName = self.mockResult?.rawValue else {
                promise(.failure(MockError.resultNotSpecified))
                return
            }

            guard let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: nil),
                  let data = try? Data(contentsOf: url),
                  let result = try? self.decoder.decode(LinkItemsResponse.self, from: data)
            else {
                promise(.failure(MockError.unknown))
                return
            }
            promise(.success(result))
        }
        .eraseToAnyPublisher()
    }
}
