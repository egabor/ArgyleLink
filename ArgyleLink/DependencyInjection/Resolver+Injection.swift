//
//  Resolver+Injection.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        registerNetworkServices()

        register { ImageCache() }
            .implements(ImageCacheProtocol.self)
            .scope(.shared)
    }

    private static func registerNetworkServices() {
        register { _ in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }

        register { _ in
            SearchApi(baseUrl: Configuration.baseUrl)
        }
        .implements(SearchApiProtocol.self)
        .scope(.shared)

        register { _ in
            GetCompaniesUseCase()
        }
        .implements(GetCompaniesUseCaseProtocol.self)

        register { BasicAuthorizationValueUseCase() }
            .implements(BasicAuthorizationValueUseCaseProtocol.self)
    }
}
